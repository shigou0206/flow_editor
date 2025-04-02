// bk_coordinate_assignment.dart

import 'dart:math' as math;

class BKCoordinateAssignment {
  final List<Node> nodes;
  final List<List<Node>> layers;
  final Map<Node, SugiyamaNodeData> nodeData;
  final SugiyamaConfiguration config;

  BKCoordinateAssignment({
    required this.nodes,
    required this.layers,
    required this.nodeData,
    required this.config,
  });

  void run() {
    // 1) markConflicts
    final conflicts = _markConflicts();

    // 2) for 4 directions => do vertical alignment + horizontal compaction
    // pass index 0..3
    for (int pass = 0; pass < 4; pass++) {
      _verticalAlignment(pass, conflicts);
      _horizontalCompaction(pass);
    }

    // 3) merge 4 sets of x coords
    _mergeCoordinates();

    // 4) assign final y (if needed)
    _assignY();
  }

  // ---------------------------
  // 1) markConflicts
  // ---------------------------
  Set<_ConflictPair> _markConflicts() {
    // TODO: implement brandes & köpf type1/type2 conflict detection
    // 这里可简化
    return {};
  }

  // ---------------------------
  // 2) verticalAlignment
  // ---------------------------
  void _verticalAlignment(int passIndex, Set<_ConflictPair> conflicts) {
    // init
    for (var n in nodes) {
      nodeData[n]!.root[passIndex] = n;
      nodeData[n]!.align[passIndex] = n;
      nodeData[n]!.sink[passIndex] = n;
      nodeData[n]!.shift[passIndex] = double.infinity;
      nodeData[n]!.x[passIndex] = double.negativeInfinity;
      nodeData[n]!.blockWidth[passIndex] = n.width;
    }

    final downward = (passIndex < 2); // 0/1 => downward
    final layerRange = downward
        ? List.generate(layers.length, (i) => i)
        : List.generate(layers.length, (i) => layers.length - 1 - i);

    for (var li in layerRange) {
      final currentLayer = layers[li];
      final leftToRight = (passIndex % 2 == 0);

      final layerNodes = leftToRight
          ? List<Node>.from(currentLayer)
          : List<Node>.from(currentLayer.reversed);

      for (var v in layerNodes) {
        final vData = nodeData[v]!;
        // 取 v 在上一层(或下一层)的中位邻居
        final neighborIds =
            downward ? vData.predecessorNodes : vData.successorNodes;
        if (neighborIds.isEmpty) continue;

        final medians = _pickMedianNeighbors(neighborIds);
        for (var m in medians) {
          // 检查是否冲突
          if (!_hasConflict(v, m, conflicts)) {
            _align(v, m, passIndex);
          }
        }
      }
    }
  }

  List<Node> _pickMedianNeighbors(List<Node> nbs) {
    // 先按照 nodeData[..].position 排序
    nbs.sort((a, b) => nodeData[a]!.position.compareTo(nodeData[b]!.position));
    if (nbs.isEmpty) return [];
    if (nbs.length % 2 == 1) {
      return [nbs[nbs.length ~/ 2]];
    } else {
      final mid = nbs.length ~/ 2;
      return [nbs[mid - 1], nbs[mid]];
    }
  }

  bool _hasConflict(Node v, Node w, Set<_ConflictPair> conflicts) {
    // TODO: implement
    // e.g. conflicts.any((p) => p.equals(v,w) )
    return false;
  }

  void _align(Node v, Node w, int passIndex) {
    final rv = _findRoot(v, passIndex);
    final rw = _findRoot(w, passIndex);
    if (rv == rw) return;
    // unify
    nodeData[rw]!.align[passIndex] = rv;
    // blockWidth= max
    nodeData[rv]!.blockWidth[passIndex] = math.max(
      nodeData[rv]!.blockWidth[passIndex],
      nodeData[rw]!.blockWidth[passIndex],
    );
    nodeData[rw]!.sink[passIndex] = rv;
  }

  Node _findRoot(Node n, int passIndex) {
    final alignN = nodeData[n]!.align[passIndex];
    if (alignN == n) {
      return n;
    } else {
      final rootN = _findRoot(alignN!, passIndex);
      nodeData[n]!.align[passIndex] = rootN;
      return rootN;
    }
  }

  // ---------------------------
  // 3) horizontalCompaction
  // ---------------------------
  void _horizontalCompaction(int passIndex) {
    // BFS layers in a direction
    final downward = (passIndex < 2);
    final layerRange = downward
        ? List.generate(layers.length, (i) => i)
        : List.generate(layers.length, (i) => layers.length - 1 - i);

    // place blocks
    for (var li in layerRange) {
      final layer = layers[li];
      final leftToRight = (passIndex % 2 == 0);
      final layerNodes = leftToRight ? layer : layer.reversed;
      for (var v in layerNodes) {
        if (_isRoot(v, passIndex)) {
          _placeBlock(v, passIndex);
        }
      }
    }

    // shift
    double d = 0;
    for (var li in layerRange) {
      final layer = layers[li];
      for (var v in layer) {
        if (_isSink(v, passIndex)) {
          final s = nodeData[v]!.shift[passIndex];
          if (s < double.infinity) {
            nodeData[v]!.shift[passIndex] = s + d;
            d += s;
          } else {
            nodeData[v]!.shift[passIndex] = 0;
          }
        }
      }
    }

    // apply shift
    for (var n in nodes) {
      final r = _findRoot(n, passIndex);
      final shiftVal = nodeData[nodeData[r]!.sink[passIndex]]!.shift[passIndex];
      if (shiftVal < double.infinity) {
        nodeData[n]!.x[passIndex] += shiftVal;
      }
    }
  }

  bool _isRoot(Node v, int passIndex) {
    return nodeData[v]!.align[passIndex] == v;
  }

  bool _isSink(Node v, int passIndex) {
    return nodeData[v]!.sink[passIndex] == v;
  }

  void _placeBlock(Node v, int passIndex) {
    if (nodeData[v]!.x[passIndex] == double.negativeInfinity) {
      nodeData[v]!.x[passIndex] = 0;
      Node w = v;
      do {
        final pred = _getPredecessorInLayer(w, passIndex);
        if (pred != null) {
          _placeBlock(_findRoot(pred, passIndex), passIndex);

          double separation = config.nodeSeparation;
          final vWidth = nodeData[w]!.isDummy ? 0 : w.width;
          final pWidth = nodeData[pred]!.isDummy ? 0 : pred.width;
          double gap = separation + 0.5 * (vWidth + pWidth);

          if (_isDifferentSink(w, pred, passIndex)) {
            final s0 = nodeData[_findRoot(pred, passIndex)]!.shift[passIndex];
            nodeData[_findRoot(pred, passIndex)]!.shift[passIndex] = math.min(
                s0,
                nodeData[w]!.x[passIndex] - nodeData[pred]!.x[passIndex] - gap);
          } else {
            nodeData[w]!.x[passIndex] = math.max(
                nodeData[w]!.x[passIndex], nodeData[pred]!.x[passIndex] + gap);
          }
        }
        w = nodeData[w]!.align[passIndex]!;
      } while (w != v);
    }
  }

  bool _isDifferentSink(Node v, Node u, int passIndex) {
    final vsink = nodeData[_findRoot(v, passIndex)]!.sink[passIndex];
    final usink = nodeData[_findRoot(u, passIndex)]!.sink[passIndex];
    return vsink != usink;
  }

  Node? _getPredecessorInLayer(Node w, int passIndex) {
    // if passIndex%2==0 => left->right => predecessor = layer[pos-1]
    // else => next
    final li = nodeData[w]!.layer;
    final layer = layers[li];
    final pos = nodeData[w]!.position;

    final leftToRight = (passIndex % 2 == 0);
    if (leftToRight) {
      if (pos > 0) return layer[pos - 1];
    } else {
      if (pos < layer.length - 1) {
        return layer[pos + 1];
      }
    }
    return null;
  }

  // ---------------------------
  // 4) mergeCoordinates
  // ---------------------------
  void _mergeCoordinates() {
    // collect for each node the 4 x-values
    final xFinal = <Node, double>{};
    for (var n in nodes) {
      final arr = nodeData[n]!.x; // x[0..3]
      double sum = 0;
      int count = 0;
      for (var xx in arr) {
        if (xx > double.negativeInfinity) {
          sum += xx;
          count++;
        }
      }
      double avg = (count == 0) ? 0 : sum / count;
      xFinal[n] = avg;
    }

    // shift min to 0
    double minVal =
        xFinal.values.fold(double.infinity, (acc, v) => math.min(acc, v));
    if (minVal == double.infinity) minVal = 0;
    for (var n in nodes) {
      xFinal[n] = xFinal[n]! - minVal;
      n.x = xFinal[n]!;
    }
  }

  void _assignY() {
    // 典型: for i in 0..layers.length => y= i*(maxHeight+ levelSeparation)
    double currentY = 0;
    for (int i = 0; i < layers.length; i++) {
      final layer = layers[i];
      double maxH = 0;
      for (var n in layer) {
        if (!nodeData[n]!.isDummy) {
          maxH = math.max(maxH, n.height);
        }
      }
      for (var n in layer) {
        n.y = currentY;
      }
      currentY += (maxH + config.levelSeparation);
    }
  }
}

// 可能需要的辅助
class SugiyamaNodeData {
  bool isDummy = false;
  int layer = 0;
  int position = 0;
  List<Node> predecessorNodes = [];
  List<Node> successorNodes = [];

  // BK data
  // align[i], sink[i], root[i], shift[i], x[i] => for pass=0..3
  // 这里演示把它都用List:
  List<Node?> align = List.filled(4, null);
  List<Node?> sink = List.filled(4, null);
  List<Node?> root = List.filled(4, null);
  List<double> shift = List.filled(4, double.infinity);
  List<double> x = List.filled(4, double.negativeInfinity);
  List<double> blockWidth = List.filled(4, 0.0);
}

class SugiyamaConfiguration {
  double nodeSeparation = 30;
  double levelSeparation = 50;
  // ...
}

class Node {
  final int id;
  double x;
  double y;
  double width;
  double height;
  Node({
    required this.id,
    this.x = 0,
    this.y = 0,
    this.width = 40,
    this.height = 40,
  });
}

class _ConflictPair {
  final Node upper;
  final Node lower;
  _ConflictPair(this.upper, this.lower);
}
