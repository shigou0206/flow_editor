import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_manager.dart';
import 'package:flow_editor/core/input/behavior_core/plugin_registry.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/utils/mouse_utils.dart';

typedef CoordinateFn = Offset Function(Offset local);
typedef PointerEventListener = void Function(PointerEvent);

class CanvasInputWrapper extends StatefulWidget {
  final Widget child;
  final CoordinateFn toCanvas;
  final InputConfig config;
  final BehaviorContext context;
  final BehaviorManager? manager;

  const CanvasInputWrapper({
    super.key,
    required this.child,
    required this.toCanvas,
    required this.context,
    this.config = const InputConfig(),
    this.manager,
  });

  @override
  State<CanvasInputWrapper> createState() => _CanvasInputWrapperState();
}

class _CanvasInputWrapperState extends State<CanvasInputWrapper> {
  late final BehaviorManager _manager = widget.manager ??
      BehaviorManager(registerDefaultBehaviors(widget.context));

  final FocusNode _focusNode = FocusNode();
  final GlobalKey _childKey = GlobalKey();
  Offset? _lastCanvasPos;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: resolveCursor(
        widget.context.getState().interaction,
        widget.context.getState().cursorBehaviorConfig,
      ),
      child: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: _onPointerDown,
          onPointerMove: _onPointer(InputEventType.pointerMove),
          onPointerUp: _onPointer(InputEventType.pointerUp),
          onPointerHover: _onPointer(InputEventType.pointerHover),
          onPointerCancel: _onPointer(InputEventType.pointerCancel),
          onPointerSignal: widget.config.enableZoom
              ? (e) {
                  if (e is PointerScrollEvent) {
                    _onPointer(InputEventType.pointerSignal)(e);
                  }
                }
              : null,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onDoubleTap: () => _dispatch(InputEvent.pointer(
              type: InputEventType.doubleTap,
              pointerEvent: null,
              canvasPos: null,
            )),
            onLongPressStart: (details) => _onLongPress(details),
            child: Container(
              key: _childKey,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  // ✅ 改良版pointerDown，明确右键事件
  void _onPointerDown(PointerDownEvent event) {
    final type = event.buttons == kSecondaryMouseButton
        ? InputEventType.pointerRightClick
        : InputEventType.pointerDown;

    final render = _childKey.currentContext?.findRenderObject();
    if (render is! RenderBox) return;

    final local = render.globalToLocal(event.position);
    final canvasPos = widget.toCanvas(local);

    _lastCanvasPos = canvasPos;

    _dispatch(InputEvent.pointer(
      type: type,
      pointerEvent: event,
      canvasPos: canvasPos,
    ));
  }

  PointerEventListener _onPointer(InputEventType type) {
    return (PointerEvent e) {
      final render = _childKey.currentContext?.findRenderObject();
      if (render is! RenderBox) return;

      final local = render.globalToLocal(e.position);
      final canvasPos = widget.toCanvas(local);

      Offset? delta;
      if (_lastCanvasPos != null && type == InputEventType.pointerMove) {
        delta = canvasPos - _lastCanvasPos!;
      }

      if (type == InputEventType.pointerMove) {
        _lastCanvasPos = canvasPos;
      } else if (type == InputEventType.pointerUp ||
          type == InputEventType.pointerCancel) {
        _lastCanvasPos = null;
      }

      _dispatch(InputEvent.pointer(
        type: type,
        pointerEvent: e,
        canvasPos: canvasPos,
        canvasPosDelta: delta,
      ));
    };
  }

  // ✅ 增加长按事件并明确位置
  void _onLongPress(LongPressStartDetails details) {
    final render = _childKey.currentContext?.findRenderObject();
    if (render is! RenderBox) return;

    final local = render.globalToLocal(details.globalPosition);
    final canvasPos = widget.toCanvas(local);

    _dispatch(InputEvent.pointer(
      type: InputEventType.longPress,
      pointerEvent: null,
      canvasPos: canvasPos,
    ));
  }

  // 键盘事件不变
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent e) {
    final type = switch (e) {
      KeyRepeatEvent _ => InputEventType.keyRepeat,
      KeyDownEvent _ => InputEventType.keyDown,
      KeyUpEvent _ => InputEventType.keyUp,
      _ => InputEventType.keyDown,
    };

    _dispatch(InputEvent.key(type: type, keyEvent: e));
    return KeyEventResult.handled;
  }

  void _dispatch(InputEvent ev) {
    _manager.handle(ev, widget.context);
  }
}
