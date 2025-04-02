import 'node_model.dart';
import 'sugiyama_data.dart';
import 'sugiyama_configuration.dart';

void minimizeCrossings(
  List<Node> nodes,
  Map<int, SugiyamaNodeData> nodeData,
  List<List<int>> layers,
  SugiyamaConfiguration config,
) {
  for (int i = 0; i < config.iterations; i++) {
    _medianPass(nodeData, layers, i);
    bool changed = _transpose(nodeData, layers);
    if (!changed) break;
  }

  for (var layer in layers) {
    int pos = 0;
    for (var nid in layer) {
      nodeData[nid]!.position = pos++;
    }
  }
}

/// median pass
void _medianPass(
  Map<int, SugiyamaNodeData> nodeData,
  List<List<int>> layers,
  int iterationIndex,
) {
  final topDown = (iterationIndex % 2 == 0);

  if (topDown) {
    for (int i = 1; i < layers.length; i++) {
      _sortByMedian(layers[i], layers[i - 1], nodeData);
    }
  } else {
    for (int i = layers.length - 2; i >= 0; i--) {
      _sortByMedian(layers[i], layers[i + 1], nodeData);
    }
  }
}

void _sortByMedian(
  List<int> currentLayer,
  List<int> adjacentLayer,
  Map<int, SugiyamaNodeData> nodeData,
) {
  // 先建 posMap
  final posMap = <int, int>{};
  for (var aid in adjacentLayer) {
    posMap[aid] = nodeData[aid]!.position;
  }

  currentLayer.sort((a, b) {
    final ma = _calcMedian(a, posMap, nodeData);
    final mb = _calcMedian(b, posMap, nodeData);
    return ma.compareTo(mb);
  });
}

int _calcMedian(
    int nid, Map<int, int> posMap, Map<int, SugiyamaNodeData> nodeData) {
  final preds = nodeData[nid]!.predecessorIds;
  if (preds.isEmpty) return 0;
  final positions = preds.map((p) => posMap[p] ?? 0).toList()..sort();
  if (positions.isEmpty) return 0;

  if (positions.length % 2 == 1) {
    return positions[positions.length ~/ 2];
  } else {
    final mid = positions.length ~/ 2;
    return ((positions[mid - 1] + positions[mid]) / 2).round();
  }
}

/// transpose
bool _transpose(Map<int, SugiyamaNodeData> nodeData, List<List<int>> layers) {
  bool changed = false;
  bool improved = true;

  while (improved) {
    improved = false;
    for (int l = 0; l < layers.length - 1; l++) {
      final upper = layers[l];
      final lower = layers[l + 1];

      final indexMap = <int, int>{};
      for (int i = 0; i < upper.length; i++) {
        indexMap[upper[i]] = i;
      }

      for (int i = 0; i < lower.length - 1; i++) {
        final v = lower[i];
        final w = lower[i + 1];
        if (_crossingCount(indexMap, nodeData, v, w) >
            _crossingCount(indexMap, nodeData, w, v)) {
          // swap
          lower[i] = w;
          lower[i + 1] = v;
          improved = true;
          changed = true;
        }
      }
    }
  }
  return changed;
}

int _crossingCount(
  Map<int, int> upperIndex,
  Map<int, SugiyamaNodeData> nodeData,
  int v,
  int w,
) {
  int cross = 0;
  final pv = nodeData[v]!.predecessorIds;
  final pw = nodeData[w]!.predecessorIds;

  for (var pnodeW in pw) {
    final idxW = upperIndex[pnodeW] ?? 0;
    for (var pnodeV in pv) {
      final idxV = upperIndex[pnodeV] ?? 0;
      if (idxV > idxW) {
        cross++;
      }
    }
  }
  return cross;
}
