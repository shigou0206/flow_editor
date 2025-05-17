import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/node_model.dart';
import 'package:flow_editor/v2/core/models/anchor_model.dart';
import 'package:flow_editor/v2/core/models/enums.dart';

/// 如果你已有 computeAnchorWorldPosition，请直接导入并使用；
/// 这里提供一个 **默认实现**，支持
///   * 内置 4 方位(left/right/top/bottom) & ratio
///   * AnchorPlacement.border / inside / outside
///   * 递归多层 parentId → world 的坐标
/// 若项目里已有更精确逻辑，可保留本文件只做 wrapper。

Offset _defaultCompute(NodeModel node, AnchorModel a) {
  late Offset base;
  switch (a.position) {
    case Position.top:
      base = Offset(
          node.position.dx + node.size.width * a.ratio, node.position.dy);
      break;
    case Position.bottom:
      base = Offset(node.position.dx + node.size.width * a.ratio,
          node.position.dy + node.size.height);
      break;
    case Position.left:
      base = Offset(
          node.position.dx, node.position.dy + node.size.height * a.ratio);
      break;
    case Position.right:
      base = Offset(node.position.dx + node.size.width,
          node.position.dy + node.size.height * a.ratio);
      break;
  }

  // placement 调整
  switch (a.placement) {
    case AnchorPlacement.inside:
      base += switch (a.position) {
        Position.top => Offset(0, a.offsetDistance),
        Position.bottom => Offset(0, -a.offsetDistance),
        Position.left => Offset(a.offsetDistance, 0),
        Position.right => Offset(-a.offsetDistance, 0),
      };
      break;
    case AnchorPlacement.outside:
      base += switch (a.position) {
        Position.top => Offset(0, -a.offsetDistance),
        Position.bottom => Offset(0, a.offsetDistance),
        Position.left => Offset(-a.offsetDistance, 0),
        Position.right => Offset(a.offsetDistance, 0),
      };
      break;
    case AnchorPlacement.border:
      // no extra offset
      break;
  }
  return base;
}

/// 对外暴露统一方法：获取锚点『中心点』(world 坐标)
/// * 如果你项目里已有 computeAnchorWorldPosition(node, anchor, allNodes)，
///   直接调用它；否则 fallback 用上面的默认实现。
Offset anchorWorldPosition(
  NodeModel node,
  AnchorModel anchor,
  List<NodeModel> allNodes, {
  Offset Function(NodeModel, AnchorModel)? customCompute,
}) {
  final topLeft =
      customCompute?.call(node, anchor) ?? _defaultCompute(node, anchor);
  return topLeft + Offset(anchor.width / 2, anchor.height / 2);
}
