// lib/core/controller/edge_controller.dart

import 'package:flutter/material.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/edit/add_edge_command.dart';
import 'package:flow_editor/core/command/edit/delete_edge_command.dart';
import 'package:flow_editor/core/command/edit/move_edge_command.dart';
import 'package:flow_editor/core/command/edit/update_edge_property_command.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/controller/edge_controller_interface.dart';

/// IEdgeController 的默认实现，内部通过 CommandManager 分发命令
class EdgeControllerImpl implements IEdgeController {
  final CommandManager _mgr;

  EdgeControllerImpl(CommandContext ctx) : _mgr = CommandManager(ctx);

  @override
  Future<void> addEdge(EdgeModel edge) {
    return _mgr.executeCommand(AddEdgeCommand(_mgr.context, edge));
  }

  @override
  Future<void> deleteEdge(String edgeId) {
    return _mgr.executeCommand(DeleteEdgeCommand(_mgr.context, edgeId));
  }

  @override
  Future<void> moveEdge(String edgeId, Offset from, Offset to) {
    final delta = to - from;
    return _mgr.executeCommand(
      MoveEdgeCommand(_mgr.context, edgeId, delta),
    );
  }

  @override
  Future<void> updateEdgeProperty(
    String edgeId,
    EdgeModel Function(EdgeModel) updateFn,
  ) {
    return _mgr.executeCommand(
      UpdateEdgePropertyCommand(_mgr.context, edgeId, updateFn),
    );
  }
}
