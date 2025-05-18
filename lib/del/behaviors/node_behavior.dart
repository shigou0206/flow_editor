import 'dart:ui';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/del/controllers/node_controller_interface.dart';

/// NodeBehavior: 定义节点事件的抽象接口或基类
/// 让具体业务逻辑在外部实现
abstract class NodeBehavior {
  final INodeController nodeController;

  NodeBehavior({
    required this.nodeController,
  });

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
}
