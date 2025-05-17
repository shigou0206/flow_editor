import 'package:flow_editor/core/behaviors/canvas_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// CanvasGestureHandler
///
/// - 使用 GestureDetector 监听手势事件：
///   onTapDown、onPanStart、onPanUpdate、onPanEnd
/// - 将这些事件转发给 multiCanvasStateProvider.notifier，由内部的
///   MultiCanvasStateNotifier 根据当前模式（createEdge、editNode、panCanvas）处理。
class CanvasGestureHandler extends ConsumerStatefulWidget {
  final Widget child;
  final CanvasBehavior behavior;

  const CanvasGestureHandler({
    super.key,
    required this.child,
    required this.behavior,
  });

  @override
  ConsumerState<CanvasGestureHandler> createState() =>
      _CanvasGestureHandlerState();
}

class _CanvasGestureHandlerState extends ConsumerState<CanvasGestureHandler> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 设置 HitTestBehavior.deferToChild 以便子组件也能接收手势
      behavior: HitTestBehavior.deferToChild,
      // 当按下时调用 onTapDown
      onTapDown: _onTapDown,
      // 拖拽开始时调用 onPanStart
      onPanStart: _onPanStart,
      // 拖拽更新时调用 onPanUpdate
      onPanUpdate: _onPanUpdate,
      // 拖拽结束时调用 onPanEnd
      onPanEnd: _onPanEnd,
      child: widget.child,
    );
  }

  void _onTapDown(TapDownDetails details) {
    // 此处以 onTapDown 作为拖拽起点触发，也可根据需求决定是否使用
    widget.behavior.onTapDown(context, details);
  }

  void _onPanStart(DragStartDetails details) {
    // 拖拽开始时调用，传入全局坐标
    widget.behavior.onPanStart(context, details);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    // 拖拽更新时传递 delta
    widget.behavior.onPanUpdate(details);
  }

  void _onPanEnd(DragEndDetails details) {
    // 拖拽结束时通知结束拖拽
    widget.behavior.onPanEnd(details);
  }
}
