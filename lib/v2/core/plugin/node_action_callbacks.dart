import 'package:flow_editor/v2/core/models/node_model.dart';

// 定义一组可选回调
class NodeActionCallbacks {
  final void Function(NodeModel node)? onRun;
  final void Function(NodeModel node)? onStop;
  final void Function(NodeModel node)? onDelete;
  final void Function(NodeModel node)? onMenu;
  final void Function(NodeModel node)? onConfigure;
  const NodeActionCallbacks({
    this.onRun,
    this.onStop,
    this.onDelete,
    this.onMenu,
    this.onConfigure,
  });
}
