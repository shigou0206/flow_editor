// lib/core/input/controller/canvas_controller.dart

import 'dart:ui';

class CanvasController {
  void startNodeDrag(String nodeId) {}

  void updateNodeDrag(Offset delta) {}

  void endNodeDrag() {}

  void panBy(Offset delta) {}

  void zoomAt(Offset focalPoint, double scaleDelta) {}

  void startEdgeDrag(String anchorId) {}

  void updateEdgeDrag(Offset canvasPos) {}

  void endEdgeDrag({String? targetNodeId, String? targetAnchorId}) {}

  void marqueeSelect(Rect area) {}

  void deleteSelection() {}

  void copySelection() {}

  void pasteClipboard() {}

  // === 撤销 & 重做 ===

  /// 撤销上一次命令
  void undo() {}

  void redo() {}
}
