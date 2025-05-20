import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';

part 'canvas_viewport_state.freezed.dart';
part 'canvas_viewport_state.g.dart';

@freezed
class CanvasViewportState with _$CanvasViewportState {
  const CanvasViewportState._(); // 允许定义自定义方法

  const factory CanvasViewportState({
    @OffsetConverter() @Default(Offset.zero) Offset offset,
    @Default(1.0) double scale,
    @SizeConverter() Size? viewportSize,
  }) = _CanvasViewportState;

  factory CanvasViewportState.fromJson(Map<String, dynamic> json) =>
      _$CanvasViewportStateFromJson(json);

  /// 将视口坐标转换为画布坐标
  Offset viewportToCanvas(Offset viewportPoint) =>
      viewportPoint / scale + offset;

  /// 将画布坐标转换为视口坐标
  Offset canvasToViewport(Offset canvasPoint) => (canvasPoint - offset) * scale;

  /// 判断画布上的点是否在视口内可见
  bool isPointVisible(Offset canvasPoint) {
    if (viewportSize == null) return true;
    final vp = canvasToViewport(canvasPoint);
    return vp.dx >= 0 &&
        vp.dy >= 0 &&
        vp.dx <= viewportSize!.width &&
        vp.dy <= viewportSize!.height;
  }

  /// 判断画布上的矩形是否在视口内可见
  bool isRectVisible(Rect canvasRect) {
    if (viewportSize == null) return true;

    final viewportRect = Offset.zero & viewportSize!;
    final transformed = Rect.fromLTRB(
      (canvasRect.left - offset.dx) * scale,
      (canvasRect.top - offset.dy) * scale,
      (canvasRect.right - offset.dx) * scale,
      (canvasRect.bottom - offset.dy) * scale,
    );
    return viewportRect.overlaps(transformed);
  }

  /// 获取视口在画布坐标系中的区域
  Rect get visibleCanvasRect {
    if (viewportSize == null) return Rect.largest;
    return Rect.fromLTWH(
      offset.dx,
      offset.dy,
      viewportSize!.width / scale,
      viewportSize!.height / scale,
    );
  }
}
