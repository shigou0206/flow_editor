import 'dart:ui';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';

/// DefaultNodeBehavior
/// 提供一个空实现或简单的Debug实现
/// 供测试或无特殊逻辑时使用
class DefaultNodeBehavior implements NodeBehavior {
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
