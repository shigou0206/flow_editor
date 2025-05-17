import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // 若需要 PointerSignalEvent
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';

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
        onEnter: (enterEvent) {},
        onHover: (hoverEvent) {
          ref
              .read(multiCanvasStateProvider.notifier)
              .onHover(context, hoverEvent.position);
        },
        onExit: (exitEvent) {},
        child: widget.child,
      ),
    );
  }
}
