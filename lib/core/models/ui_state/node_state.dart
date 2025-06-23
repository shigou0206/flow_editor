import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:collection/collection.dart';
part 'node_state.freezed.dart';
part 'node_state.g.dart';

@freezed
class NodeState with _$NodeState {
  const NodeState._(); // 自定义方法

  const factory NodeState({
    @Default([]) List<NodeModel> nodes,
    @Default(1) int version,
  }) = _NodeState;

  factory NodeState.fromJson(Map<String, dynamic> json) =>
      _$NodeStateFromJson(json);

  NodeState updateNodes(List<NodeModel> updated) {
    return copyWith(nodes: updated, version: version + 1);
  }

  NodeModel? getById(String nodeId) {
    return nodes.firstWhereOrNull((n) => n.id == nodeId);
  }

  NodeState removeNode(String nodeId) {
    return copyWith(
      nodes: nodes.where((n) => n.id != nodeId).toList(),
      version: version + 1,
    );
  }

  NodeState upsertNode(NodeModel node) {
    final filtered = nodes.where((n) => n.id != node.id).toList();
    return copyWith(
      nodes: [...filtered, node],
      version: version + 1,
    );
  }
}
