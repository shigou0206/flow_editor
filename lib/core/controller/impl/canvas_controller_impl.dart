// lib/core/input/controller/canvas_controller.dart

import 'package:flutter/material.dart';
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

/// 直接实现 ICanvasController
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

  // ============ INodeController ============
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
    String id,
    NodeModel Function(NodeModel) fn,
  ) =>
      _nodeCtrl.updateNodeProperty(id, fn);
  @override
  Future<void> groupNodes(List<String> ids) => _nodeCtrl.groupNodes(ids);
  @override
  Future<void> ungroupNodes(String id) => _nodeCtrl.ungroupNodes(id);

  // ============ IEdgeController ============
  @override
  Future<void> addEdge(EdgeModel edge) => _edgeCtrl.addEdge(edge);
  @override
  Future<void> deleteEdge(String id) => _edgeCtrl.deleteEdge(id);
  @override
  Future<void> moveEdge(String id, Offset from, Offset to) =>
      _edgeCtrl.moveEdge(id, from, to);
  @override
  Future<void> updateEdgeProperty(
    String id,
    EdgeModel Function(EdgeModel) fn,
  ) =>
      _edgeCtrl.updateEdgeProperty(id, fn);

  // ============ IViewportController ============
  @override
  Future<void> panBy(Offset delta) => _vpCtrl.panBy(delta);
  @override
  Future<void> zoomAt(Offset focalPoint, double delta) =>
      _vpCtrl.zoomAt(focalPoint, delta);

  // ============ ISelectionController ============
  @override
  Future<void> selectNodes(Set<String> ids) => _selCtrl.selectNodes(ids);
  @override
  Future<void> selectEdges(Set<String> ids) => _selCtrl.selectEdges(ids);
  @override
  Future<void> clearSelection() => _selCtrl.clearSelection();

  // ============ IExecutionController ============
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

  // ============ undo / redo ============
  @override
  void undo() => _cmd.undo();
  @override
  void redo() => _cmd.redo();
}
