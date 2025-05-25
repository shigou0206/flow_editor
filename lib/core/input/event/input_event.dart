import 'package:flutter/services.dart';
import 'input_event_type.dart';

class InputEvent {
  final InputEventType type;
  final PointerEvent? pointerEvent; // 鼠标/触摸事件专用
  final KeyEvent? keyEvent; // 键盘事件专用
  final Offset? canvasPos; // 画布坐标
  final Offset? canvasPosDelta; // 画布坐标变化量（拖拽用）
  final LogicalKeyboardKey? key; // 键盘按键快捷访问

  // Pointer专用构造函数
  InputEvent.pointer({
    required this.type,
    required this.pointerEvent,
    required this.canvasPos,
    this.canvasPosDelta,
  })  : keyEvent = null,
        key = null;

  // Keyboard专用构造函数
  InputEvent.key({
    required this.type,
    required this.keyEvent,
  })  : pointerEvent = null,
        canvasPos = null,
        canvasPosDelta = null,
        key = keyEvent?.logicalKey;
}
