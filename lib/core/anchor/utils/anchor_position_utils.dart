import 'dart:math';
import 'package:flutter/material.dart';
import '../../node/models/node_model.dart';
import '../models/anchor_model.dart';
import '../models/anchor_enums.dart';
import '../../types/position_enum.dart';

/// ---------------------
/// 1) 计算锚点在节点内部的局部坐标
/// ---------------------
Offset computeAnchorLocalPosition(
  AnchorModel anchor,
  Size nodeSize, {
  double anchorWidgetSize = 24.0,
}) {
  final double w = nodeSize.width;
  final double h = nodeSize.height;

  // 1) 基准点：根据 anchor 的位置和 ratio 计算
  final (baseX, baseY) = switch (anchor.position) {
    Position.left => (0.0, h * anchor.ratio),
    Position.right => (w, h * anchor.ratio),
    Position.top => (w * anchor.ratio, 0.0),
    Position.bottom => (w * anchor.ratio, h),
  };

  // 2) 获取法线方向向量（节点外侧为正方向）
  final normal = _getNormalVector(anchor.position);
  // 3) 旋转该向量，根据 anchor.angle 调整
  final rotatedNormal = _rotateVector(normal, anchor.angle);

  // 4) 根据 anchor.placement 调整 offsetDistance
  double distance = anchor.offsetDistance;
  switch (anchor.placement) {
    case AnchorPlacement.outside:
      // outside：向外延伸，额外加上半个锚点尺寸
      distance += anchorWidgetSize * 0.5;
      break;
    case AnchorPlacement.inside:
      // inside：向内缩进，取负值
      distance = -(distance + anchorWidgetSize * 0.5);
      break;
    case AnchorPlacement.border:
      distance = 0;
      break;
  }

  // 5) 最终局部坐标 = 基准点 + 旋转后的法线向量 * distance
  final dx = baseX + rotatedNormal.dx * distance;
  final dy = baseY + rotatedNormal.dy * distance;
  return Offset(dx, dy);
}

/// ---------------------
/// 2) 计算锚点在画布(世界)上的坐标
/// ---------------------
Offset computeAnchorWorldPosition(
  NodeModel node,
  AnchorModel anchor, {
  double anchorWidgetSize = 24.0,
}) {
  final nodePos = Offset(node.x, node.y);
  final localAnchorPos = computeAnchorLocalPosition(
    anchor,
    Size(node.width, node.height),
    anchorWidgetSize: anchorWidgetSize,
  );
  return nodePos + localAnchorPos;
}

/// ---------------------
/// 3) 计算外扩: 用于确定父容器(BoundingBox)需要多大
///    当 anchor.placement == outside 时，需要额外空间来包含整个锚点圆
/// ---------------------
_AnchorPadding computeAnchorPadding(
  List<AnchorModel> anchors, {
  double anchorWidgetSize = 24.0,
}) {
  double expandLeft = 0;
  double expandRight = 0;
  double expandTop = 0;
  double expandBottom = 0;

  for (final anchor in anchors) {
    if (anchor.placement == AnchorPlacement.outside) {
      // 需要的扩展距离 = offsetDistance + 整个锚点尺寸 (确保整颗锚点圆都能显示)
      final double needed = anchor.offsetDistance + anchorWidgetSize;
      switch (anchor.position) {
        case Position.left:
          if (needed > expandLeft) expandLeft = needed;
          break;
        case Position.right:
          if (needed > expandRight) expandRight = needed;
          break;
        case Position.top:
          if (needed > expandTop) expandTop = needed;
          break;
        case Position.bottom:
          if (needed > expandBottom) expandBottom = needed;
          break;
      }
    }
  }

  return _AnchorPadding(
    left: expandLeft,
    right: expandRight,
    top: expandTop,
    bottom: expandBottom,
  );
}

/// ---------------------
/// 用于存储上下左右的外扩距离
/// ---------------------
class _AnchorPadding {
  final double left;
  final double right;
  final double top;
  final double bottom;

  const _AnchorPadding({
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
  });
}

/// ---------------------
/// 基于 position 返回一个指向“节点外侧”的法线单位向量
/// ---------------------
Offset _getNormalVector(Position position) {
  switch (position) {
    case Position.left:
      return const Offset(-1, 0);
    case Position.right:
      return const Offset(1, 0);
    case Position.top:
      return const Offset(0, -1);
    case Position.bottom:
      return const Offset(0, 1);
  }
}

/// ---------------------
/// 旋转向量：将 [vector] 旋转 [angleDegree] 度
/// ---------------------
Offset _rotateVector(Offset vector, double angleDegree) {
  if (angleDegree == 0) return vector;
  final radians = angleDegree * pi / 180;
  final cosT = cos(radians);
  final sinT = sin(radians);

  return Offset(
    vector.dx * cosT - vector.dy * sinT,
    vector.dx * sinT + vector.dy * cosT,
  );
}
