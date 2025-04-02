import 'node_model.dart';
import 'edge_model.dart';
import 'sugiyama_data.dart';

void removeDummyNodes(
  List<Node> nodes,
  List<Edge> edges,
  Map<int, SugiyamaNodeData> nodeData,
  Map<String, SugiyamaEdgeData> edgeData,
  List<List<int>> layers,
) {
  // 跳过最上层和最下层
  for (int i = 1; i < layers.length - 1; i++) {
    final layerCopy = List<int>.from(layers[i]);
    for (var did in layerCopy) {
      if (nodeData[did]!.isDummy) {
        final preds = nodeData[did]!.predecessorIds;
        final succs = nodeData[did]!.successorIds;
        if (preds.length == 1 && succs.length == 1) {
          final p = preds[0];
          final s = succs[0];

          edges.removeWhere((e) =>
              (e.sourceId == p && e.targetId == did) ||
              (e.sourceId == did && e.targetId == s));
          nodeData[p]!.successorIds.remove(did);
          nodeData[s]!.predecessorIds.remove(did);

          // 合并到 p->s
          var exist = edges.firstWhere(
            (e) => e.sourceId == p && e.targetId == s,
            orElse: () => Edge(sourceId: -1, targetId: -1),
          );
          if (exist.sourceId == -1) {
            exist = Edge(sourceId: p, targetId: s);
            edges.add(exist);
            nodeData[p]!.successorIds.add(s);
            nodeData[s]!.predecessorIds.add(p);
          }

          // 把 dummy 坐标加入到 bendPoints
          final dummyNode = nodes.firstWhere((nd) => nd.id == did);
          final dx = dummyNode.x;
          final dy = dummyNode.y;
          final key = '$p->$s';
          final eData = edgeData.putIfAbsent(key, () => SugiyamaEdgeData());
          eData.bendPoints.add(dx);
          eData.bendPoints.add(dy);

          // 删除 dummy 节点
          nodes.removeWhere((n) => n.id == did);
          nodeData.remove(did);
        }
      }
    }
  }
}

void restoreReversedEdges(
  List<Node> nodes,
  List<Edge> edges,
  Map<int, SugiyamaNodeData> nodeData,
  Map<String, SugiyamaEdgeData> edgeData,
) {
  for (var entry in nodeData.entries) {
    final nodeId = entry.key;
    final data = entry.value;
    if (data.reversed.isNotEmpty) {
      for (var tgt in data.reversed) {
        final idx =
            edges.indexWhere((e) => e.sourceId == tgt && e.targetId == nodeId);
        if (idx >= 0) {
          edges.removeAt(idx);
          edges.add(Edge(sourceId: nodeId, targetId: tgt));

          nodeData[tgt]!.successorIds.remove(nodeId);
          nodeData[nodeId]!.predecessorIds.remove(tgt);

          nodeData[nodeId]!.successorIds.add(tgt);
          nodeData[tgt]!.predecessorIds.add(nodeId);

          final oldKey = '$tgt->$nodeId';
          final oldData = edgeData.remove(oldKey);
          if (oldData != null) {
            final newKey = '$nodeId->$tgt';
            edgeData[newKey] = oldData;
          }
        }
      }
    }
  }
}
