class SugiyamaNodeData {
  bool isDummy = false;
  int layer = 0;
  int position = 0;
  int median = 0;
  // 记录反转的目标节点id，用于后续恢复边
  final List<int> reversed = [];

  final List<int> predecessorIds = [];
  final List<int> successorIds = [];
}

class SugiyamaEdgeData {
  /// 存储弯曲点 (x1, y1, x2, y2, ...)
  List<double> bendPoints = [];
}
