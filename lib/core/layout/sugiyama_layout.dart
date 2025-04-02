import 'node_model.dart';
import 'edge_model.dart';
import 'sugiyama_configuration.dart';
import 'sugiyama_data.dart';

import 'cycle_removal.dart';
import 'layer_assignment.dart';
import 'node_ordering.dart';
import 'coordinate_assignment.dart';
import 'dummy_handling.dart';

void runSugiyamaLayout({
  required List<Node> nodes,
  required List<Edge> edges,
  required SugiyamaConfiguration config,
}) {
  // 构建 nodeData, edgeData
  final nodeData = <int, SugiyamaNodeData>{};
  final edgeData = <String, SugiyamaEdgeData>{};

  for (var n in nodes) {
    nodeData[n.id] = SugiyamaNodeData();
  }
  for (var e in edges) {
    nodeData[e.sourceId]!.successorIds.add(e.targetId);
    nodeData[e.targetId]!.predecessorIds.add(e.sourceId);
  }

  // 1. 去环
  removeCycles(nodes, edges, nodeData);

  // 2. 分层
  final layers = <List<int>>[];
  assignLayers(nodes, edges, nodeData, layers);

  // 3. 交叉最小化
  minimizeCrossings(nodes, nodeData, layers, config);

  // 4. 坐标分配
  assignCoordinates(nodes, nodeData, layers, config);

  // 5. 去 Dummy
  removeDummyNodes(nodes, edges, nodeData, edgeData, layers);

  // 6. 恢复反转
  restoreReversedEdges(nodes, edges, nodeData, edgeData);

  // 现在 nodes 的 (x,y) 就是布局后的结果
  // edgeData 里可存放弯曲点信息
}
