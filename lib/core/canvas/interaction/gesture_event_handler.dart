import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/canvas_state/canvas_state_provider.dart';

/// CanvasGestureHandler
///
/// - 在整个画布区域使用 [Listener] 监听指针事件：
///    [onPointerDown], [onPointerMove], [onPointerUp] 和 [onPointerCancel]
/// - 将这些事件转发给 [multiCanvasStateProvider.notifier]，
///   由内部的 [MultiCanvasStateNotifier] 根据当前模式
///   (createEdge、editNode、panCanvas) 进行处理。
class CanvasGestureHandler extends ConsumerStatefulWidget {
  final Widget child;

  const CanvasGestureHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  ConsumerState<CanvasGestureHandler> createState() =>
      _CanvasGestureHandlerState();
}

class _CanvasGestureHandlerState extends ConsumerState<CanvasGestureHandler> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: widget.child,
    );
  }

  /// 当指针按下时，转换全局坐标到局部坐标，并通知拖拽开始
  void _onPointerDown(PointerDownEvent event) {
    debugPrint('[PointerDown] globalPos=${event.position}');
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final localPos = renderBox.globalToLocal(event.position);
      debugPrint('[PointerDown] localPos=$localPos');
    }
    ref.read(multiCanvasStateProvider.notifier).startDrag(event.position);
  }

  /// 指针移动时，将 [event.delta] 传递给拖拽更新
  void _onPointerMove(PointerMoveEvent event) {
    ref.read(multiCanvasStateProvider.notifier).updateDrag(event.delta);
  }

  /// 指针抬起时，通知拖拽结束
  void _onPointerUp(PointerUpEvent event) {
    ref.read(multiCanvasStateProvider.notifier).endDrag();
  }

  /// 指针取消时，也通知拖拽结束
  void _onPointerCancel(PointerCancelEvent event) {
    ref.read(multiCanvasStateProvider.notifier).endDrag();
  }
}
