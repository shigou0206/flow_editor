import 'node_model.dart';
import 'edge_model.dart';
import 'sugiyama_data.dart';

/// 分层 + 插入 Dummy
void assignLayers(
  List<Node> nodes,
  List<Edge> edges,
  Map<int, SugiyamaNodeData> nodeData,
  List<List<int>> layers,
) {
  _kahnLayering(nodes, nodeData, layers);
  _insertDummyNodes(nodes, edges, nodeData, layers);
}

/// 1) 拓扑分层 (Kahn)
void _kahnLayering(
  List<Node> nodes,
  Map<int, SugiyamaNodeData> nodeData,
  List<List<int>> layers,
) {
  final inDegree = <int, int>{};
  for (var n in nodes) {
    inDegree[n.id] = nodeData[n.id]!.predecessorIds.length;
  }

  final queue = <int>[];
  for (var n in nodes) {
    if (inDegree[n.id]! == 0) {
      queue.add(n.id);
    }
  }

  int currentLayerIndex = 0;
  while (queue.isNotEmpty) {
    final size = queue.length;
    final layerNodes = <int>[];
    for (int i = 0; i < size; i++) {
      int nid = queue.removeAt(0);
      layerNodes.add(nid);
      nodeData[nid]!.layer = currentLayerIndex;

      for (var succId in nodeData[nid]!.successorIds) {
        inDegree[succId] = (inDegree[succId] ?? 0) - 1;
        if (inDegree[succId] == 0) {
          queue.add(succId);
        }
      }
    }
    layers.add(layerNodes);
    currentLayerIndex++;
  }
}

/// 2) 跨层边 => 插入dummy
void _insertDummyNodes(
  List<Node> nodes,
  List<Edge> edges,
  Map<int, SugiyamaNodeData> nodeData,
  List<List<int>> layers,
) {
  final originalEdges = List<Edge>.from(edges);

  for (var e in originalEdges) {
    final s = e.sourceId;
    final t = e.targetId;
    final ls = nodeData[s]!.layer;
    final lt = nodeData[t]!.layer;
    final diff = (lt - ls).abs();
    if (diff > 1) {
      // 长边
      edges.remove(e);

      int curr = s;
      for (int midL = ls + 1; midL < lt; midL++) {
        final dummyId = ('dummy:$curr->$midL->$t').hashCode;
        final dummyNode = Node(id: dummyId, width: 0, height: 0);
        nodes.add(dummyNode);

        nodeData[dummyId] = SugiyamaNodeData()
          ..isDummy = true
          ..layer = midL;

        layers[midL].add(dummyId);

        nodeData[curr]!.successorIds.add(dummyId);
        nodeData[dummyId]!.predecessorIds.add(curr);
        edges.add(Edge(sourceId: curr, targetId: dummyId));

        curr = dummyId;
      }

      edges.add(Edge(sourceId: curr, targetId: t));
      nodeData[curr]!.successorIds.add(t);
      nodeData[t]!.predecessorIds.add(curr);
    }
  }
}
