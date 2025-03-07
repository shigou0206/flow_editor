// default_node_behavior.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/node_model.dart';
import 'node_behavior.dart';

/// DefaultNodeBehavior
/// 提供一个空实现或简单的Debug实现
/// 供测试或无特殊逻辑时使用
class DefaultNodeBehavior implements NodeBehavior {
  @override
  void onTap(NodeModel node) {
    // debugPrint('Default onTap: ${node.id}');
  }

  @override
  void onDoubleTap(NodeModel node) {
    // debugPrint('Default onDoubleTap: ${node.id}');
  }

  @override
  void onDelete(NodeModel node) {
    // debugPrint('Default onDelete: ${node.id}');
  }

  @override
  void onHover(NodeModel node, bool isHover) {
    // debugPrint('Default onHover: ${node.id} => $isHover');
  }

  @override
  void onContextMenu(NodeModel node, Offset position) {
    // debugPrint('Default onContextMenu: ${node.id} at $position');
  }

  /// 拖拽开始
  @override
  void onDragStart(NodeModel node, DragStartDetails details) {
    // debugPrint('Default onDragStart: ${node.id}');
  }

  /// 拖拽更新
  @override
  void onDragUpdate(NodeModel node, DragUpdateDetails details) {
    // debugPrint('Default onDragUpdate: ${node.id}, delta=${details.delta}');
  }

  /// 拖拽结束
  @override
  void onDragEnd(NodeModel node, DragEndDetails details) {
    // debugPrint('Default onDragEnd: ${node.id}');
  }
}
