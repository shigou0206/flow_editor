// lib/core/utils/id_generator.dart

String createEdgeId(String v, String w, String? name, bool isDirected) {
  if (isDirected || v.compareTo(w) <= 0) {
    return name != null ? '$v\u0001$w\u0001$name' : '$v\u0001$w\u0001\u0000';
  } else {
    return name != null ? '$w\u0001$v\u0001$name' : '$w\u0001$v\u0001\u0000';
  }
}

class IdGenerator {
  static int _nodeCounter = 0;
  static int _edgeCounter = 0;
  static int _groupCounter = 0;

  static String nextNodeId() => 'node_${++_nodeCounter}';
  static String nextEdgeId() => 'edge_${++_edgeCounter}';
  static String nextGroupId() => 'group_${++_groupCounter}';

  static String generateEdgeId(
    String? sourceNodeId,
    String? targetNodeId,
    String? sourceAnchorId,
    String? targetAnchorId,
    String? name, {
    bool isDirected = true,
  }) {
    final sourceAnchor = sourceAnchorId ?? "";
    final targetAnchor = targetAnchorId ?? "";
    final source = sourceNodeId ?? "";
    final target = targetNodeId ?? "";

    String? anchorName;
    if (sourceAnchorId != null && targetAnchorId != null) {
      if (sourceAnchorId.compareTo(targetAnchorId) <= 0) {
        anchorName = "$sourceAnchor\u0001$targetAnchor";
      } else {
        anchorName = "$targetAnchor\u0001$sourceAnchor";
      }
    }

    if (anchorName != null && name != null) {
      name = "$anchorName\u0001$name";
    }

    return createEdgeId(source, target, name, isDirected);
  }
}
