import 'dart:ui';

abstract class CanvasHitTester {
  String? hitTestNode(Offset pos);

  String? hitTestAnchor(Offset pos);

  String? hitTestEdge(Offset pos);

  String? hitTestElement(Offset pos) {
    final anchorId = hitTestAnchor(pos);
    if (anchorId != null) return anchorId;
    final nodeId = hitTestNode(pos);
    if (nodeId != null) return nodeId;
    return hitTestEdge(pos);
  }
}
