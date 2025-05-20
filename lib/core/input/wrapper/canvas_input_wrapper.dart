// lib/core/input/wrapper/canvas_input_wrapper.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flow_editor/core/input/behavior_core/behavior_manager.dart';
import 'package:flow_editor/core/input/behavior_core/plugin_registry.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/input/config/config.dart';

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
  final GlobalKey _childKey = GlobalKey(); // ← added GlobalKey
  Offset? _lastCanvasPos;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _onPointer(InputEventType.pointerDown),
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
            raw: null,
            canvasPos: null,
          )),
          onLongPress: () => _dispatch(InputEvent.pointer(
            type: InputEventType.longPress,
            raw: null,
            canvasPos: null,
          )),
          child: Container(
            key: _childKey, // ← wrap child in keyed Container
            child: widget.child,
          ),
        ),
      ),
    );
  }

  PointerEventListener _onPointer(InputEventType type) {
    return (PointerEvent e) {
      // delay render box lookup until event time
      final render = _childKey.currentContext?.findRenderObject();
      if (render is! RenderBox) return;
      final local = render.globalToLocal(e.position);
      final canvasPos = widget.toCanvas(local);

      Offset? delta;
      if (_lastCanvasPos != null && type == InputEventType.pointerMove) {
        delta = canvasPos - _lastCanvasPos!;
      }

      if (type == InputEventType.pointerDown ||
          type == InputEventType.pointerMove) {
        _lastCanvasPos = canvasPos;
      } else if (type == InputEventType.pointerUp ||
          type == InputEventType.pointerCancel) {
        _lastCanvasPos = null;
      }

      _dispatch(InputEvent.pointer(
        type: type,
        raw: e,
        canvasPos: canvasPos,
        canvasPosDelta: delta,
      ));
    };
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent e) {
    final type = switch (e) {
      KeyRepeatEvent _ => InputEventType.keyRepeat,
      KeyDownEvent _ => InputEventType.keyDown,
      KeyUpEvent _ => InputEventType.keyUp,
      _ => InputEventType.keyDown,
    };

    _dispatch(InputEvent.key(type: type, raw: e, key: e.logicalKey));
    return KeyEventResult.handled;
  }

  void _dispatch(InputEvent ev) {
    _manager.handle(ev, widget.context);
  }
}
