import 'node_model.dart';
import 'edge_model.dart';
import 'sugiyama_data.dart';

/// 通过 DFS 查找并反转环边
void removeCycles(
  List<Node> nodes,
  List<Edge> edges,
  Map<int, SugiyamaNodeData> nodeData,
) {
  final visited = <int>{};
  final stack = <int>{};

  for (var n in nodes) {
    if (!visited.contains(n.id)) {
      _dfsRemoveCycle(n.id, visited, stack, nodeData, edges);
    }
  }
}

void _dfsRemoveCycle(
  int currentId,
  Set<int> visited,
  Set<int> stack,
  Map<int, SugiyamaNodeData> nodeData,
  List<Edge> edges,
) {
  visited.add(currentId);
  stack.add(currentId);

  for (var succId in nodeData[currentId]!.successorIds) {
    if (stack.contains(succId)) {
      // 检测到环 -> 反转
      _reverseEdge(currentId, succId, edges, nodeData);
    } else if (!visited.contains(succId)) {
      _dfsRemoveCycle(succId, visited, stack, nodeData, edges);
    }
  }

  stack.remove(currentId);
}

/// 反转 (from->to) => (to->from)
void _reverseEdge(
  int from,
  int to,
  List<Edge> edges,
  Map<int, SugiyamaNodeData> nodeData,
) {
  final idx = edges.indexWhere((e) => e.sourceId == from && e.targetId == to);
  if (idx >= 0) {
    edges.removeAt(idx);
    edges.add(Edge(sourceId: to, targetId: from));

    nodeData[from]!.reversed.add(to);

    // 更新 predecessor/successor
    nodeData[from]!.successorIds.remove(to);
    nodeData[to]!.predecessorIds.remove(from);

    nodeData[to]!.successorIds.add(from);
    nodeData[from]!.predecessorIds.add(to);
  }
}
