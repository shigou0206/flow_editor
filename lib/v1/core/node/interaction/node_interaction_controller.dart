import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';

/// NodeInteractionController 封装了节点交互的常见回调。
///
/// 通过这个控制器，节点及其子组件可以统一处理以下交互：
/// - [onTap]: 单击操作
/// - [onDoubleTap]: 双击操作
/// - [onHover]: 鼠标悬停（进入/离开）操作
/// - [onContextMenu]: 右键点击（上下文菜单）操作
///
/// 你可以通过传入不同的回调实现来定制不同节点的交互行为，
/// 同时也可以通过 [copyWith] 方法构建新的控制器实例。
class NodeInteractionController {
  final void Function(NodeModel node)? onTap;
  final void Function(NodeModel node)? onDoubleTap;
  final void Function(NodeModel node, bool isHover)? onHover;
  final void Function(NodeModel node, Offset position)? onContextMenu;
  final void Function(NodeModel node)? onDelete;

  const NodeInteractionController({
    this.onTap,
    this.onDoubleTap,
    this.onHover,
    this.onContextMenu,
    this.onDelete,
  });

  /// 复制当前实例，并允许覆盖部分回调
  NodeInteractionController copyWith({
    void Function(NodeModel node)? onTap,
    void Function(NodeModel node)? onDoubleTap,
    void Function(NodeModel node, bool isHover)? onHover,
    void Function(NodeModel node, Offset position)? onContextMenu,
    void Function(NodeModel node)? onDelete,
  }) {
    return NodeInteractionController(
      onTap: onTap ?? this.onTap,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      onHover: onHover ?? this.onHover,
      onContextMenu: onContextMenu ?? this.onContextMenu,
      onDelete: onDelete ?? this.onDelete,
    );
  }

  /// 以下方法用于从 UI 层调用控制器的事件，确保节点信息被正确传递。
  void handleTap(NodeModel node) => onTap?.call(node);
  void handleDoubleTap(NodeModel node) => onDoubleTap?.call(node);
  void handleHover(NodeModel node, bool isHover) =>
      onHover?.call(node, isHover);
  void handleContextMenu(NodeModel node, Offset position) =>
      onContextMenu?.call(node, position);
  void handleDelete(NodeModel node) => onDelete?.call(node);
}
