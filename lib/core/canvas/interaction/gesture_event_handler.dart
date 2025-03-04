import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 根据你项目实际的相对路径，引入 multiCanvasStateProvider
import '../../state_management/canvas_state/canvas_state_provider.dart';

/// CanvasGestureHandler
/// 
/// - 在整个画布区域用 [Listener] 监听指针事件：
///    [onPointerDown], [onPointerMove], [onPointerUp]
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
      child: widget.child,
    );
  }

  /// 当指针按下时 => startDrag
  void _onPointerDown(PointerDownEvent event) {
    ref.read(multiCanvasStateProvider.notifier).startDrag(event.position);
  }

  /// 指针移动时 => updateDrag
  /// 注意，这里把 [event.delta] 传下去即可
  void _onPointerMove(PointerMoveEvent event) {
    ref.read(multiCanvasStateProvider.notifier).updateDrag(event.delta);
  }

  /// 指针抬起时 => endDrag
  void _onPointerUp(PointerUpEvent event) {
    ref.read(multiCanvasStateProvider.notifier).endDrag();
  }
}