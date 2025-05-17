import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/node_state.dart';
import 'package:flow_editor/v2/core/models/node_model.dart';
import 'package:flow_editor/v2/core/state_management/providers/edge_state_provider.dart';

class NodeStateNotifier extends StateNotifier<NodeState> {
  NodeStateNotifier(this._ref, {required this.workflowId})
      : super(const NodeState());

  final String workflowId;
  final Ref _ref;

  // ───────────────────────── helpers ─────────────────────────
  List<NodeModel> _list() => state.nodesOf(workflowId);

  void _removeEdgesOf(String nodeId) => _ref
      .read(edgeStateProvider(workflowId).notifier)
      .removeEdgesOfNode(nodeId);

  // ───────────────────────── CRUD ────────────────────────────
  void upsertNode(NodeModel node) {
    final updated = [
      ..._list().where((n) => n.id != node.id),
      node,
    ]..sort((a, b) => a.id.compareTo(b.id)); // 保序
    state = state.updateWorkflowNodes(workflowId, updated);
  }

  void upsertNodes(List<NodeModel> newNodes) {
    final map = {for (var n in _list()) n.id: n};
    bool changed = false;
    for (var n in newNodes) {
      if (map[n.id] != n) {
        map[n.id] = n;
        changed = true;
      }
    }
    if (changed) {
      final list = map.values.toList()..sort((a, b) => a.id.compareTo(b.id));
      state = state.updateWorkflowNodes(workflowId, list);
    }
  }

  void removeNode(String nodeId) {
    if (!_list().any((n) => n.id == nodeId)) return;
    final updated = _list().where((n) => n.id != nodeId).toList();
    state = state.updateWorkflowNodes(workflowId, updated);
    _removeEdgesOf(nodeId); // ★ 同步删边
  }

  void removeNodes(List<String> nodeIds) {
    final updated = _list().where((n) => !nodeIds.contains(n.id)).toList();
    if (updated.length == _list().length) return;
    state = state.updateWorkflowNodes(workflowId, updated);
    for (final id in nodeIds) {
      _removeEdgesOf(id); // ★ 同步删边
    }
  }

  void moveNode(String nodeId, Offset delta) {
    if (delta == Offset.zero) return; // ★ 零位跳过
    final updated = _list().map((n) {
      if (n.id == nodeId) {
        return n.copyWith(position: n.position + delta);
      }
      return n;
    }).toList();
    state = state.updateWorkflowNodes(workflowId, updated);
  }

  // ─────────────────── workflow helpers ───────────────────
  void clearWorkflow() {
    if (_list().isEmpty) return;
    state = state.updateWorkflowNodes(workflowId, []);
  }

  void removeWorkflow() => state = state.removeWorkflow(workflowId);

  // ───────────────────── getters ─────────────────────
  NodeModel? getNode(String id) {
    for (final node in _list()) {
      if (node.id == id) return node;
    }
    return null;
  }

  List<NodeModel> getNodes() => _list();

  bool nodeExists(String id) => _list().any((n) => n.id == id);

  void add(NodeModel n) => upsertNode(n);

  /// 供外部调用的简单别名
  void move(String nodeId, Offset delta) => moveNode(nodeId, delta);
}
