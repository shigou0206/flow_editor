import 'dart:ui';
import 'package:flow_editor/v2/core/models/node_model.dart';
import 'package:flow_editor/v2/core/controllers/node_controller_interface.dart';
import 'package:flow_editor/v2/core/behaviors/node_behavior.dart';

/// DefaultNodeBehavior
/// 提供一个空实现或简单的Debug实现
/// 供测试或无特殊逻辑时使用
class DefaultNodeBehavior implements NodeBehavior {
  @override
  final INodeController nodeController;

  /// 默认使用 NodeController
  DefaultNodeBehavior({
    required this.nodeController,
  });

  @override
  void onTap(NodeModel node) {}

  @override
  void onDoubleTap(NodeModel node) {}

  @override
  void onDelete(NodeModel node) {}

  @override
  void onHover(NodeModel node, bool isHover) {}

  @override
  void onContextMenu(NodeModel node, Offset position) {}
}
