import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // 若需要 PointerSignalEvent
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 如果您想在滚轮时缩放/平移画布，就要使用 multiCanvasStateProvider
import '../canvas_state/canvas_state_provider.dart';

/// CanvasMouseHandler
/// - 用 MouseRegion 监听鼠标进入/悬停/离开
/// - 用 Listener 监听滚轮事件 (onPointerSignal)
/// - 在滚轮事件中可执行放大/缩小
class CanvasMouseHandler extends ConsumerStatefulWidget {
  final Widget child;

  const CanvasMouseHandler({super.key, required this.child});

  @override
  ConsumerState<CanvasMouseHandler> createState() => _CanvasMouseHandlerState();
}

class _CanvasMouseHandlerState extends ConsumerState<CanvasMouseHandler> {
  // 可选：若需要追踪当前鼠标位置/悬停
  // ignore: unused_field
  Offset? _hoverPosition;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        // 监听滚轮滚动: PointerScrollEvent
        if (pointerSignal is PointerScrollEvent) {
          // 假设当用户滚轮向上 => 放大，向下 => 缩小
          final dy = pointerSignal.scrollDelta.dy;
          final scaleFactor = dy < 0 ? 1.1 : 0.9;
          // 也可以更加精细
          ref
              .read(multiCanvasStateProvider.notifier)
              .zoomAtPoint(scaleFactor, pointerSignal.position);
        }
      },
      child: MouseRegion(
        onEnter: (enterEvent) {
          // 鼠标进入画布区域
          debugPrint('Mouse entered canvas area: ${enterEvent.position}');
        },
        onHover: (hoverEvent) {
          // 鼠标在画布上悬停移动
          setState(() {
            _hoverPosition = hoverEvent.position;
          });
          // 若您想在状态中存或给 multiCanvasStateNotifier,也可以
          // e.g. ref.read(multiCanvasStateProvider.notifier).setHoverPos(hoverEvent.position);
        },
        onExit: (exitEvent) {
          // 鼠标离开画布区域
          debugPrint('Mouse exited canvas area.');
          setState(() {
            _hoverPosition = null;
          });
        },
        child: widget.child,
      ),
    );
  }
}
