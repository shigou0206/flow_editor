import 'package:flutter/material.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';

/// CanvasGestureHandler
///
/// 使用 GestureDetector 监听手势事件：
class CanvasGestureHandler extends StatefulWidget {
  final CanvasBehavior behavior;
  final Widget child;

  /// 构造时需要一个 [CanvasBehavior] 用于处理真正的交互逻辑
  const CanvasGestureHandler({
    super.key,
    required this.behavior,
    required this.child,
  });

  @override
  State<CanvasGestureHandler> createState() => _CanvasGestureHandlerState();
}

class _CanvasGestureHandlerState extends State<CanvasGestureHandler> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    // 如果你想在按下时就开始“pan”逻辑：
    widget.behavior.startPan(details.globalPosition);
  }

  void _onPanStart(DragStartDetails details) {
    // 拖拽开始
    widget.behavior.startPan(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    // 拖拽更新
    widget.behavior.updatePan(details.globalPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    // 拖拽结束
    widget.behavior.endPan();
  }
}
