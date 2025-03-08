import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 这里的导入路径根据你实际项目结构调整
import '../canvas_state/canvas_state_provider.dart';

/// CanvasGestureHandler
///
/// - 在整个画布区域用 [Listener] 监听指针事件：
///   [onPointerDown], [onPointerMove], [onPointerUp]
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
      // PointerDown => 通知 StateNotifier 的 startDrag(context, globalPos)
      onPointerDown: _onPointerDown,
      // PointerMove => 通知 StateNotifier 的 updateDrag( delta )
      onPointerMove: _onPointerMove,
      // PointerUp   => 通知 StateNotifier 的 endDrag()
      onPointerUp: _onPointerUp,
      child: widget.child,
    );
  }

  /// 指针按下 => 调用 startDrag(BuildContext, globalPos)
  void _onPointerDown(PointerDownEvent event) {
    debugPrint('[PointerDown] globalPos=${event.position}');
    // 如果需要调试 localPos （相对于本 Widget 的坐标），可打印:
    final localPos =
        (context.findRenderObject() as RenderBox).globalToLocal(event.position);
    debugPrint('[PointerDown] localPos=$localPos');

    // 调用 StateNotifier
    ref
        .read(multiCanvasStateProvider.notifier)
        .startDrag(context, event.position);
  }

  /// 指针移动 => 调用 updateDrag( delta )
  /// 注意: 在你的 MultiCanvasStateNotifier 里,
  ///       _updateEdgeDrag / _dragNodeBy / _panCanvas 均基于“增量”处理
  void _onPointerMove(PointerMoveEvent event) {
    ref.read(multiCanvasStateProvider.notifier).updateDrag(event.delta);
  }

  /// 指针抬起 => 调用 endDrag()
  void _onPointerUp(PointerUpEvent event) {
    ref.read(multiCanvasStateProvider.notifier).endDrag();
  }
}
