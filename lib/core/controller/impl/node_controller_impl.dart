import 'package:flutter/material.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/edit/add_node_command.dart';
import 'package:flow_editor/core/command/edit/delete_node_command.dart';
import 'package:flow_editor/core/command/edit/delete_node_with_edges_command.dart';
import 'package:flow_editor/core/command/edit/move_node_command.dart';
import 'package:flow_editor/core/command/edit/update_node_property_command.dart';
import 'package:flow_editor/core/command/edit/group_nodes_command.dart';
import 'package:flow_editor/core/command/edit/ungroup_nodes_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/controller/node_controller_interface.dart';

class NodeControllerImpl implements INodeController {
  final CommandManager _mgr;

  NodeControllerImpl(CommandContext ctx) : _mgr = CommandManager(ctx);

  @override
  Future<void> addNode(NodeModel node) =>
      _mgr.executeCommand(AddNodeCommand(_mgr.context, node));

  @override
  Future<void> deleteNode(String nodeId) =>
      _mgr.executeCommand(DeleteNodeCommand(_mgr.context, nodeId));

  @override
  Future<void> deleteNodeWithEdges(String nodeId) =>
      _mgr.executeCommand(DeleteNodeWithEdgesCommand(_mgr.context, nodeId));

  @override
  Future<void> moveNode(String nodeId, Offset to) =>
      _mgr.executeCommand(MoveNodeCommand(_mgr.context, nodeId, to));

  @override
  Future<void> updateNodeProperty(
    String nodeId,
    NodeModel Function(NodeModel) updateFn,
  ) =>
      _mgr.executeCommand(
          UpdateNodePropertyCommand(_mgr.context, nodeId, updateFn));

  @override
  Future<void> groupNodes(List<String> nodeIds) =>
      _mgr.executeCommand(GroupNodesCommand(_mgr.context, nodeIds));

  @override
  Future<void> ungroupNodes(String groupId) =>
      _mgr.executeCommand(UngroupNodesCommand(_mgr.context, groupId));
}
