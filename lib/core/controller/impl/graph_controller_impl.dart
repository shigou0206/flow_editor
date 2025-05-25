import 'package:flow_editor/core/controller/interfaces/graph_controller.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

// 导入所有相关的 Command
import 'package:flow_editor/core/command/edit/add_node_command.dart';
import 'package:flow_editor/core/command/edit/delete_node_command.dart';
import 'package:flow_editor/core/command/edit/delete_node_with_edges_command.dart';
import 'package:flow_editor/core/command/edit/delete_node_with_auto_reconnect_command.dart';
import 'package:flow_editor/core/command/edit/move_node_command.dart';
import 'package:flow_editor/core/command/edit/update_node_property_command.dart';
import 'package:flow_editor/core/command/edit/group_nodes_command.dart';
import 'package:flow_editor/core/command/edit/ungroup_nodes_command.dart';
import 'package:flow_editor/core/command/edit/duplicate_node_command.dart';

import 'package:flow_editor/core/command/edit/add_edge_command.dart';
import 'package:flow_editor/core/command/edit/delete_edge_command.dart';
import 'package:flow_editor/core/command/edit/move_edge_command.dart';
import 'package:flow_editor/core/command/edit/update_edge_property_command.dart';

import 'package:flow_editor/core/command/edit/select_nodes_command.dart';
import 'package:flow_editor/core/command/edit/select_edges_command.dart';
import 'package:flow_editor/core/command/edit/clear_selection_command.dart';

import 'package:flow_editor/core/command/edit/copy_selection_command.dart';
import 'package:flow_editor/core/command/edit/paste_clipboard_command.dart';

import 'package:flow_editor/core/command/layout/layout_command.dart';
import 'package:flutter/material.dart';

class GraphControllerImpl implements IGraphController {
  final CommandManager _cmdMgr;
  final CommandContext _ctx;

  GraphControllerImpl(this._ctx) : _cmdMgr = CommandManager(_ctx);

  // === Nodes ===

  @override
  Future<void> addNode(NodeModel node) {
    return _cmdMgr.executeCommand(AddNodeCommand(_ctx, node));
  }

  @override
  Future<void> deleteNode(String nodeId) {
    return _cmdMgr.executeCommand(DeleteNodeCommand(_ctx, nodeId));
  }

  @override
  Future<void> deleteNodeWithEdges(String nodeId) {
    return _cmdMgr.executeCommand(DeleteNodeWithEdgesCommand(_ctx, nodeId));
  }

  @override
  Future<void> deleteNodeWithAutoReconnect(String nodeId) async {
    final command = DeleteNodeWithAutoReconnectCommand(_ctx, nodeId);
    await _cmdMgr.executeCommand(command);
    await applyLayout();
  }

  @override
  Future<void> moveNode(String nodeId, Offset to) {
    return _cmdMgr.executeCommand(MoveNodeCommand(_ctx, nodeId, to));
  }

  @override
  Future<void> updateNodeProperty(
    String nodeId,
    NodeModel Function(NodeModel) updateFn,
  ) {
    return _cmdMgr.executeCommand(
      UpdateNodePropertyCommand(_ctx, nodeId, updateFn),
    );
  }

  @override
  Future<void> groupNodes(List<String> nodeIds) {
    return _cmdMgr.executeCommand(GroupNodesCommand(_ctx, nodeIds));
  }

  @override
  Future<void> ungroupNodes(String groupId) {
    return _cmdMgr.executeCommand(UngroupNodesCommand(_ctx, groupId));
  }

  @override
  Future<void> duplicateNode(String nodeId) {
    return _cmdMgr.executeCommand(DuplicateNodeCommand(_ctx, nodeId));
  }

  // === Edges ===

  @override
  Future<void> addEdge(EdgeModel edge) {
    return _cmdMgr.executeCommand(AddEdgeCommand(_ctx, edge));
  }

  @override
  Future<void> deleteEdge(String edgeId) {
    return _cmdMgr.executeCommand(DeleteEdgeCommand(_ctx, edgeId));
  }

  @override
  Future<void> moveEdge(String edgeId, Offset from, Offset to) {
    final delta = to - from;
    return _cmdMgr.executeCommand(MoveEdgeCommand(_ctx, edgeId, delta));
  }

  @override
  Future<void> updateEdgeProperty(
    String edgeId,
    EdgeModel Function(EdgeModel) updateFn,
  ) {
    return _cmdMgr.executeCommand(
      UpdateEdgePropertyCommand(_ctx, edgeId, updateFn),
    );
  }

  @override
  Future<void> insertNodeIntoEdge(NodeModel node, String edgeId) async {
    final state = _ctx.getState();

    // 获取要拆分的原始边
    final originalEdge =
        state.edgeState.edges.firstWhere((edge) => edge.id == edgeId);

    debugPrint(
        '[🔍 InsertNodeIntoEdge]: Original Edge Found - id=${originalEdge.id}, source=${originalEdge.sourceNodeId}, target=${originalEdge.targetNodeId}');

    // 获取原边源节点，推断 parentId
    final sourceNode = state.nodeState.nodes
        .firstWhere((node) => node.id == originalEdge.sourceNodeId);

    final parentId = sourceNode.parentId;

    // 删除原来的边
    await _cmdMgr.executeCommand(DeleteEdgeCommand(_ctx, edgeId));
    debugPrint('[🔴 Edge Deleted]: id=$edgeId');

    // 新节点带上 parentId 信息
    final nodeWithParent = node.copyWith(parentId: parentId);

    // 添加新的节点
    await _cmdMgr.executeCommand(AddNodeCommand(_ctx, nodeWithParent));
    debugPrint(
        '[🟢 Node Added]: id=${nodeWithParent.id}, type=${nodeWithParent.type}, position=${nodeWithParent.position}, parentId=${nodeWithParent.parentId}');

    // 新建两条边（源节点 -> 新节点，新节点 -> 目标节点）
    final edgeToNewNode = EdgeModel.generated(
      sourceNodeId: originalEdge.sourceNodeId,
      sourceAnchorId: originalEdge.sourceAnchorId,
      targetNodeId: nodeWithParent.id,
    );

    final edgeFromNewNode = EdgeModel.generated(
      sourceNodeId: nodeWithParent.id,
      targetNodeId: originalEdge.targetNodeId,
      targetAnchorId: originalEdge.targetAnchorId,
    );

    // 添加新的两条边
    await _cmdMgr.executeCommand(AddEdgeCommand(_ctx, edgeToNewNode));
    debugPrint(
        '[🟢 Edge Added]: id=${edgeToNewNode.id}, source=${edgeToNewNode.sourceNodeId}, target=${edgeToNewNode.targetNodeId}');

    await _cmdMgr.executeCommand(AddEdgeCommand(_ctx, edgeFromNewNode));
    debugPrint(
        '[🟢 Edge Added]: id=${edgeFromNewNode.id}, source=${edgeFromNewNode.sourceNodeId}, target=${edgeFromNewNode.targetNodeId}');

    await applyLayout();
  }

  @override
  Future<void> insertNodeGroupIntoEdge(
    NodeModel groupNode,
    List<NodeModel> children,
    List<EdgeModel> edges,
    String edgeId,
  ) async {
    final state = _ctx.getState();

    // 获取要拆分的原始边
    final originalEdge =
        state.edgeState.edges.firstWhere((edge) => edge.id == edgeId);

    final sourceNodeId = originalEdge.sourceNodeId;
    final targetNodeId = originalEdge.targetNodeId;

    if (sourceNodeId == null || targetNodeId == null) {
      throw Exception('原始边的 sourceNodeId 或 targetNodeId 为 null');
    }

    debugPrint('[🔍 InsertGroupIntoEdge]: Original Edge - id=$edgeId');

    // 获取原边源节点的 parentId
    final sourceNode =
        state.nodeState.nodes.firstWhere((node) => node.id == sourceNodeId);
    final parentId = sourceNode.parentId;

    // 新的节点列表：包含现有节点 + 新增的group节点和子节点（parentId需更新）
    final updatedNodes = [
      ...state.nodeState.nodes,
      groupNode.copyWith(parentId: parentId),
      ...children.map((child) => child.copyWith(parentId: groupNode.id)),
    ];

    // 新的边列表：移除原边，添加group内部边和外部连接边
    final updatedEdges = [
      for (final edge in state.edgeState.edges)
        if (edge.id != edgeId) edge,

      // 新增 group 内部的 edges
      ...edges,

      // 连接原 source 节点到 groupNode
      EdgeModel.generated(
        sourceNodeId: sourceNodeId,
        sourceAnchorId: originalEdge.sourceAnchorId,
        targetNodeId: groupNode.id,
      ),

      // 连接 groupNode 到原 target 节点
      EdgeModel.generated(
        sourceNodeId: groupNode.id,
        targetNodeId: targetNodeId,
        targetAnchorId: originalEdge.targetAnchorId,
      ),
    ];

    // 执行一次性整体更新
    _ctx.updateState(
      _ctx.getState().copyWith(
            nodeState: _ctx.getState().nodeState.copyWith(nodes: updatedNodes),
            edgeState: _ctx.getState().edgeState.copyWith(edges: updatedEdges),
          ),
    );

// 执行布局命令 (不带参数)
    await _cmdMgr.executeCommand(LayoutCommand(_ctx));

    debugPrint('[✅ Group inserted successfully]');
  }

  // === Selection ===

  @override
  Future<void> selectNodes(Set<String> nodeIds) {
    return _cmdMgr.executeCommand(SelectNodesCommand(_ctx, nodeIds));
  }

  @override
  Future<void> selectEdges(Set<String> edgeIds) {
    return _cmdMgr.executeCommand(SelectEdgesCommand(_ctx, edgeIds));
  }

  @override
  Future<void> clearSelection() {
    return _cmdMgr.executeCommand(ClearSelectionCommand(_ctx));
  }

  // === Clipboard operations ===

  @override
  Future<void> copySelection() {
    return _cmdMgr.executeCommand(CopySelectionCommand(_ctx));
  }

  @override
  Future<void> pasteClipboard() {
    return _cmdMgr.executeCommand(PasteClipboardCommand(_ctx));
  }

  @override
  Future<void> applyLayout() {
    return _cmdMgr.executeCommand(LayoutCommand(_ctx));
  }

  // === Undo & Redo ===

  @override
  Future<void> undo() => _cmdMgr.undo();

  @override
  Future<void> redo() => _cmdMgr.redo();
}
