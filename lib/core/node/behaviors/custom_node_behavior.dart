import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/node_model.dart';
import 'node_behavior.dart';
import '../controllers/node_controller.dart'; // 若需要调用 NodeController

/// CustomNodeBehavior
/// 这里既可以是一个空实现，也可以将 NodeController 注入进来，
/// 以便在回调内直接调用状态管理逻辑。
class CustomNodeBehavior implements NodeBehavior {
  final NodeController? nodeController;

  /// 如果需要用到 NodeController, 可以在构造函数里注入
  CustomNodeBehavior({this.nodeController});

  @override
  void onTap(NodeModel node) {
    debugPrint('[CustomNodeBehavior] onTap => ${node.id}');
    // 可在此处理节点选中、激活等逻辑
  }

  @override
  void onDoubleTap(NodeModel node) {
    debugPrint('[CustomNodeBehavior] onDoubleTap => ${node.id}');
    // 双击节点时的逻辑
  }

  @override
  void onDelete(NodeModel node) {
    debugPrint('[CustomNodeBehavior] onDelete => ${node.id}');
    // 如果需要删除节点，可直接调用 nodeController
    nodeController?.removeNode(node.id);
  }

  @override
  void onHover(NodeModel node, bool isHover) {
    debugPrint('[CustomNodeBehavior] onHover => ${node.id}, isHover=$isHover');
    // 悬停时可以设置节点高亮之类的
  }

  @override
  void onContextMenu(NodeModel node, Offset position) {
    debugPrint('[CustomNodeBehavior] onContextMenu => ${node.id} at $position');
    // 右键菜单：在此处弹出菜单或执行其他操作
  }

  @override
  void onDragStart(NodeModel node, DragStartDetails details) {
    debugPrint('[CustomNodeBehavior] onDragStart => ${node.id}');
    // 若需要在拖拽前做些处理，如记录初始位置
    nodeController?.onNodeDragStart(node, details);
  }

  @override
  void onDragUpdate(NodeModel node, DragUpdateDetails details) {
    debugPrint('[CustomNodeBehavior] onDragUpdate => ${node.id}');
    // 调用 NodeController 移动节点
    nodeController?.onNodeDragUpdate(node, details);
  }

  @override
  void onDragEnd(NodeModel node, DragEndDetails details) {
    debugPrint('[CustomNodeBehavior] onDragEnd => ${node.id}');
    // 拖拽结束，可以执行收尾逻辑或调用 NodeController
    nodeController?.onNodeDragEnd(node, details);
  }
}
