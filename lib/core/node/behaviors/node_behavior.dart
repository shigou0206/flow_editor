// node_behavior.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/node_model.dart';

/// NodeBehavior: 定义节点事件的抽象接口或基类
/// 让具体业务逻辑在外部实现
abstract class NodeBehavior {
  /// 单击
  void onTap(NodeModel node) {}

  /// 双击
  void onDoubleTap(NodeModel node) {}

  /// 删除按钮点击
  void onDelete(NodeModel node) {}

  /// 鼠标悬停
  void onHover(NodeModel node, bool isHover) {}

  /// 右键菜单
  void onContextMenu(NodeModel node, Offset position) {}

  /// 拖拽开始
  void onDragStart(NodeModel node, DragStartDetails details) {}

  /// 拖拽更新
  void onDragUpdate(NodeModel node, DragUpdateDetails details) {}

  /// 拖拽结束
  void onDragEnd(NodeModel node, DragEndDetails details) {}
}
