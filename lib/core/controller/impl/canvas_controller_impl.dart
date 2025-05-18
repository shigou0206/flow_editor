// lib/core/input/controller/canvas_controller.dart

import 'dart:ui';

import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/controller/canvas_controller_interface.dart';
import 'package:flow_editor/core/controller/node_controller_interface.dart';
import 'package:flow_editor/core/controller/edge_controller_interface.dart';
import 'package:flow_editor/core/controller/viewport_controller_interface.dart';
import 'package:flow_editor/core/controller/selection_controller_interface.dart';
import 'package:flow_editor/core/controller/execution_controller_interface.dart';
import 'package:flow_editor/core/controller/impl/node_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/edge_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/viewport_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/selection_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/execution_controller_impl.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 聚合型 Controller，行为层（Behavior）和命令层（Command）都用同一个实例。
class CanvasController implements ICanvasController {
  final CommandManager _cmd;
  final INodeController _nodeCtrl;
  final IEdgeController _edgeCtrl;
  final IViewportController _vpCtrl;
  final ISelectionController _selCtrl;
  final IExecutionController _execCtrl;

  CanvasController(CommandContext ctx)
      : _cmd = CommandManager(ctx),
        _nodeCtrl = NodeControllerImpl(ctx),
        _edgeCtrl = EdgeControllerImpl(ctx),
        _vpCtrl = ViewportControllerImpl(ctx),
        _selCtrl = SelectionControllerImpl(ctx),
        _execCtrl = ExecutionControllerImpl(ctx);

  // ===========================================================================
  // === Behavior 层要用的“低级画布操作”，留空或更新状态即可，外面用 StateNotifier 驱动重绘
  // ===========================================================================

  @override
  void startNodeDrag(String nodeId) {}

  @override
  void updateNodeDrag(Offset delta) {}

  @override
  void endNodeDrag() {}

  @override
  void startEdgeDrag(String anchorId) {}

  @override
  void updateEdgeDrag(Offset canvasPos) {}

  @override
  void endEdgeDrag({String? targetNodeId, String? targetAnchorId}) {}

  @override
  void marqueeSelect(Rect area) {}

  @override
  void deleteSelection() {}

  @override
  void copySelection() {}

  @override
  void pasteClipboard() {}

  @override
  void undo() => _cmd.undo();

  @override
  void redo() => _cmd.redo();

  // ===========================================================================
  // === 命令层要用的“高层 API”，都直接委托给对应的 ICommand
  // ===========================================================================

  // Node
  @override
  Future<void> addNode(NodeModel node) => _nodeCtrl.addNode(node);

  @override
  Future<void> deleteNode(String id) => _nodeCtrl.deleteNode(id);

  @override
  Future<void> deleteNodeWithEdges(String id) =>
      _nodeCtrl.deleteNodeWithEdges(id);

  @override
  Future<void> moveNode(String id, Offset to) => _nodeCtrl.moveNode(id, to);

  @override
  Future<void> updateNodeProperty(
          String id, NodeModel Function(NodeModel) fn) =>
      _nodeCtrl.updateNodeProperty(id, fn);

  @override
  Future<void> groupNodes(List<String> ids) => _nodeCtrl.groupNodes(ids);

  @override
  Future<void> ungroupNodes(String id) => _nodeCtrl.ungroupNodes(id);

  // Edge
  @override
  Future<void> addEdge(EdgeModel edge) => _edgeCtrl.addEdge(edge);

  @override
  Future<void> deleteEdge(String id) => _edgeCtrl.deleteEdge(id);

  @override
  Future<void> moveEdge(String id, Offset from, Offset to) =>
      _edgeCtrl.moveEdge(id, from, to);

  @override
  Future<void> updateEdgeProperty(
          String id, EdgeModel Function(EdgeModel) fn) =>
      _edgeCtrl.updateEdgeProperty(id, fn);

  // Selection
  @override
  Future<void> selectNodes(Set<String> ids) => _selCtrl.selectNodes(ids);

  @override
  Future<void> selectEdges(Set<String> ids) => _selCtrl.selectEdges(ids);

  @override
  Future<void> clearSelection() => _selCtrl.clearSelection();

  // Viewport
  @override
  Future<void> panBy(Offset pos) => _vpCtrl.panBy(pos);

  @override
  Future<void> zoomAt(Offset focalPoint, double scaleDelta) =>
      _vpCtrl.zoomAt(focalPoint, scaleDelta);

  // Execution
  @override
  Future<void> runNode(String id, {Map<String, dynamic>? data}) =>
      _execCtrl.runNode(id, data: data);

  @override
  Future<void> stopNode(String id, {Map<String, dynamic>? data}) =>
      _execCtrl.stopNode(id, data: data);

  @override
  Future<void> failNode(String id, {Map<String, dynamic>? data}) =>
      _execCtrl.failNode(id, data: data);

  @override
  Future<void> completeNode(String id, {Map<String, dynamic>? data}) =>
      _execCtrl.completeNode(id, data: data);

  @override
  Future<void> runWorkflow({Map<String, dynamic>? data}) =>
      _execCtrl.runWorkflow(data: data);

  @override
  Future<void> cancelWorkflow({Map<String, dynamic>? data}) =>
      _execCtrl.cancelWorkflow(data: data);

  @override
  Future<void> failWorkflow({Map<String, dynamic>? data}) =>
      _execCtrl.failWorkflow(data: data);

  @override
  Future<void> completeWorkflow({Map<String, dynamic>? data}) =>
      _execCtrl.completeWorkflow(data: data);
}
