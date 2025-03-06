import 'dart:math';
import 'package:flutter/material.dart';
import '../../node/models/node_model.dart';
import '../models/anchor_model.dart';
import '../models/anchor_enums.dart';
import '../../types/position_enum.dart';

/// ---------------------
/// 1) 计算锚点在节点内部的局部坐标
/// ---------------------
Offset computeAnchorLocalPosition(AnchorModel anchor, Size nodeSize) {
  final double w = nodeSize.width;
  final double h = nodeSize.height;

  // 锚点尺寸假设为正方形或者以宽度作为统一标量
  final double anchorDimension = anchor.width;

  // 1) 计算基准点（基于 anchor 的位置和比例）
  final (baseX, baseY) = switch (anchor.position) {
    Position.left => (0.0, h * anchor.ratio),
    Position.right => (w, h * anchor.ratio),
    Position.top => (w * anchor.ratio, 0.0),
    Position.bottom => (w * anchor.ratio, h),
  };

  // 2) 获取法线向量（指向节点外侧）
  final normal = _getNormalVector(anchor.position);
  // 3) 根据 anchor.angle 对法线进行旋转
  final rotatedNormal = _rotateVector(normal, anchor.angle);

  // 4) 计算统一的偏移距离 effectiveDistance
  //    外侧：正值；内侧：负值；边界：0
  double effectiveDistance;
  switch (anchor.placement) {
    case AnchorPlacement.outside:
      effectiveDistance = anchor.offsetDistance + anchorDimension * 0.5;
      break;
    case AnchorPlacement.inside:
      effectiveDistance = -(anchor.offsetDistance + anchorDimension * 0.5);
      break;
    case AnchorPlacement.border:
      effectiveDistance = 0;
      break;
  }

  // 5) position

  // 6) 最终局部坐标 = 基准点 + (rotatedNormal * effectiveDistance)
  final dx = baseX + rotatedNormal.dx * effectiveDistance;
  final dy = baseY + rotatedNormal.dy * effectiveDistance;
  return Offset(dx, dy);
}

/// ---------------------
/// 2) 计算锚点在画布(世界)上的坐标
/// ---------------------
Offset computeAnchorWorldPosition(NodeModel node, AnchorModel anchor) {
  final nodePos = Offset(node.x, node.y);
  final localAnchorPos =
      computeAnchorLocalPosition(anchor, Size(node.width, node.height));
  return nodePos + localAnchorPos;
}

/// ---------------------
/// 3) 计算外扩: 用于确定父容器(BoundingBox)需要多大
AnchorPadding computeAnchorPadding(
  List<AnchorModel> anchors,
  NodeModel node,
) {
  double expandLeft = 0;
  double expandRight = 0;
  double expandTop = 0;
  double expandBottom = 0;

  for (final anchor in anchors) {
    final localPos =
        computeAnchorLocalPosition(anchor, Size(node.width, node.height));
    expandLeft = max(expandLeft, node.width - localPos.dx);
    expandRight = max(expandRight, localPos.dx + anchor.width - node.width);
    expandTop = max(expandTop, node.height - localPos.dy);
    expandBottom = max(expandBottom, localPos.dy + anchor.height - node.height);
  }

  return AnchorPadding(
    left: expandLeft,
    right: expandRight,
    top: expandTop,
    bottom: expandBottom,
  );
}

// /// ---------------------
// /// 用于存储上下左右的外扩距离
// /// ---------------------
class AnchorPadding {
  final double left;
  final double right;
  final double top;
  final double bottom;

  const AnchorPadding({
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
