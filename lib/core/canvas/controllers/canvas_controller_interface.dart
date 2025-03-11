import 'dart:ui';

/// ICanvasController：用于对画布进行平移/缩放/视图适配等操作的接口。
abstract class ICanvasController {
  void startPan(Offset globalPosition);
  void updatePan(Offset globalPosition);
  void endPan();
  void zoom(double zoomFactor, Offset focalPoint);
  void resetView();
  void fitView(Rect contentBounds, Size viewportSize, {double padding = 20});
  void panBy(double dx, double dy);
}
