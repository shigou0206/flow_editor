import 'dart:ui';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/v1/core/node/controllers/node_controller_interface.dart';

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
