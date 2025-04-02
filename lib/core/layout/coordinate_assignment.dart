import 'node_model.dart';
import 'sugiyama_data.dart';
import 'sugiyama_configuration.dart';

void assignCoordinates(
  List<Node> nodes,
  Map<int, SugiyamaNodeData> nodeData,
  List<List<int>> layers,
  SugiyamaConfiguration config,
) {
  _assignY(nodes, nodeData, layers, config);
  _assignX(nodes, nodeData, layers, config);
  // 如果需要 orientation翻转，可在此额外处理
}

void _assignY(
  List<Node> nodes,
  Map<int, SugiyamaNodeData> nodeData,
  List<List<int>> layers,
  SugiyamaConfiguration config,
) {
  double currentY = 0.0;
  for (int i = 0; i < layers.length; i++) {
    final layerIds = layers[i];
    double maxH = 0.0;
    for (var id in layerIds) {
      if (!nodeData[id]!.isDummy) {
        final n = nodes.firstWhere((node) => node.id == id);
        if (n.height > maxH) {
          maxH = n.height;
        }
      }
    }
    for (var id in layerIds) {
      final node = nodes.firstWhere((n) => n.id == id);
      node.y = currentY;
    }
    currentY += maxH + config.levelSeparation;
  }
}

void _assignX(
  List<Node> nodes,
  Map<int, SugiyamaNodeData> nodeData,
  List<List<int>> layers,
  SugiyamaConfiguration config,
) {
  for (var layer in layers) {
    layer
        .sort((a, b) => nodeData[a]!.position.compareTo(nodeData[b]!.position));
    double currentX = 0.0;
    for (var id in layer) {
      final nd = nodes.firstWhere((n) => n.id == id);
      nd.x = currentX;
      if (!nodeData[id]!.isDummy) {
        currentX += (nd.width + config.nodeSeparation);
      } else {
        currentX += config.nodeSeparation;
      }
    }
  }
}
