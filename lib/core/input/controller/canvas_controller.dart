import 'package:flutter/material.dart';

class CanvasController {
  void startNodeDrag(String nodeId) {}
  void updateNodeDrag(Offset delta) {}
  void endNodeDrag() {}

  void panBy(Offset delta) {}
  void zoomAt(Offset focalPoint, double scaleDelta) {}

  void startEdgeDrag(String anchorId) {}
  void updateEdgeDrag(Offset pos) {}
  void endEdgeDrag({String? targetNodeId, String? targetAnchorId}) {}

  void marqueeSelect(Rect area) {}
  void deleteSelection() {}

  void copySelection() {}
  void pasteClipboard() {}

  void undo() {}
  void redo() {}
}
