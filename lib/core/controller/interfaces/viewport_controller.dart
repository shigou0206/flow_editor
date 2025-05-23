// interfaces/viewport_controller.dart

import 'dart:ui';

abstract class IViewportController {
  void panBy(Offset delta);
  void panTo(Offset position);
  void zoomAt(Offset focalPoint, double scaleDelta);
  void zoomTo(double scale);
  void focusOnPosition(Offset position);
}
