import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/core/canvas/controllers/canvas_controller_interface.dart';

/// CanvasController：具体实现 [ICanvasController]，
/// 内部通过 [multiCanvasStateProvider] 操作画布平移/缩放等。
class CanvasController implements ICanvasController {
  final WidgetRef ref;

  /// 记录平移拖拽的上一次位置
  Offset? _lastPanPosition;

  CanvasController({
    required this.ref,
  });

  /// 便于计算移动量时获取当前缩放
  double get _scale => ref.read(multiCanvasStateProvider).activeState.scale;

  @override
  void startPan(Offset globalPosition) {
    _lastPanPosition = globalPosition;
  }

  @override
  void updatePan(Offset globalPosition) {
    if (_lastPanPosition == null) return;

    // 计算本次移动的 delta
    final delta = globalPosition - _lastPanPosition!;
    // 将屏幕距离转换到画布坐标中 (除以 scale)
    ref.read(multiCanvasStateProvider.notifier).panBy(
          -delta.dx / _scale,
          -delta.dy / _scale,
        );

    // 记录新的位置
    _lastPanPosition = globalPosition;
  }

  @override
  void endPan() {
    _lastPanPosition = null;
  }

  @override
  void zoom(double zoomFactor, Offset focalPoint) {
    // 调用已有的 zoomAtPoint 接口
    ref
        .read(multiCanvasStateProvider.notifier)
        .zoomAtPoint(zoomFactor, focalPoint);
  }

  @override
  void resetView() {
    // 将画布重置到默认
    ref.read(multiCanvasStateProvider.notifier).resetCanvas();
  }

  @override
  void fitView(Rect contentBounds, Size viewportSize, {double padding = 20}) {
    final scaleX = (viewportSize.width - padding * 2) / contentBounds.width;
    final scaleY = (viewportSize.height - padding * 2) / contentBounds.height;
    final newScale = scaleX < scaleY ? scaleX : scaleY;

    final contentCenter = contentBounds.center;
    final viewportCenter = viewportSize.center(Offset.zero);

    // 同时设置缩放与偏移
    ref.read(multiCanvasStateProvider.notifier)
      ..setScale(newScale)
      ..setOffset(contentCenter - viewportCenter / newScale);
  }

  @override
  void panBy(double dx, double dy) {
    ref.read(multiCanvasStateProvider.notifier).panBy(dx, dy);
  }
}
