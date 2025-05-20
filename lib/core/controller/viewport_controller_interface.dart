import 'package:flutter/widgets.dart';

/// 画布视口（Viewport）控制器接口
abstract class IViewportController {
  /// 平移画布视口，delta 是在画布坐标系下的位移
  Future<void> panBy(Offset delta);

  /// 以 [focalPoint]（视口坐标）为焦点，缩放画布
  /// [scaleDelta] 是相对缩放因子，比如 1.1 表示放大 10%
  Future<void> zoomAt(Offset focalPoint, double scaleDelta);
}
