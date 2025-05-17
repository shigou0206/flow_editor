import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/node_model.dart';
import 'package:flow_editor/v2/core/models/anchor_model.dart';
import 'package:flow_editor/v2/core/models/enums.dart';

/// ---------------------
/// 1) 计算锚点在节点内部的局部坐标
/// ---------------------
Offset computeAnchorLocalPosition(AnchorModel anchor, Size nodeSize) {
  final double w = nodeSize.width;
  final double h = nodeSize.height;

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
      effectiveDistance = anchor.offsetDistance;
      break;
    case AnchorPlacement.inside:
      effectiveDistance = -anchor.offsetDistance;
      break;
    case AnchorPlacement.border:
      effectiveDistance = 0;
      break;
  }

  // 5) position

  // 6) 最终局部坐标 = 基准点 + (rotatedNormal * effectiveDistance)
  final dx = baseX + rotatedNormal.dx * effectiveDistance - anchor.width / 2;
  final dy = baseY + rotatedNormal.dy * effectiveDistance - anchor.height / 2;
  return Offset(dx, dy);
}

/// ---------------------
/// 2) 计算锚点在画布(世界)上的坐标
/// ---------------------
Offset computeAnchorWorldPosition(
  NodeModel node,
  AnchorModel anchor,
  List<NodeModel>? allNodes,
) {
  final localAnchorPos = computeAnchorLocalPosition(
    anchor,
    Size(node.size.width, node.size.height),
  );

  final nodePos =
      (allNodes == null) ? node.position : node.absolutePosition(allNodes);

  return nodePos + localAnchorPos;
}

/// ---------------------
/// 3) 计算外扩: 用于确定父容器(BoundingBox)需要多大
AnchorPadding computeAnchorPadding(
  List<AnchorModel> anchors,
  Size nodeSize,
) {
  double expandLeft = 0;
  double expandRight = 0;
  double expandTop = 0;
  double expandBottom = 0;

  for (final anchor in anchors) {
    final localPos = computeAnchorLocalPosition(anchor, nodeSize);
    expandLeft = max(expandLeft, -localPos.dx);
    expandRight = max(expandRight, localPos.dx + anchor.width - nodeSize.width);
    expandTop = max(expandTop, -localPos.dy);
    expandBottom =
        max(expandBottom, localPos.dy + anchor.height - nodeSize.height);
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

  factory AnchorPadding.fromJson(Map<String, dynamic> json) {
    return AnchorPadding(
      left: json['left'],
      right: json['right'],
      top: json['top'],
      bottom: json['bottom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'left': left,
      'right': right,
      'top': top,
      'bottom': bottom,
    };
  }
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
