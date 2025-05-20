import 'package:flutter/services.dart';
import 'input_event_type.dart';

class InputEvent {
  final InputEventType type;
  final dynamic raw; // 原生 Flutter 事件
  final Offset? canvasPos; // 画布坐标
  final Offset? canvasPosDelta; // Add this field
  final LogicalKeyboardKey? key; // 键盘按键

  InputEvent.pointer({
    required this.type,
    required this.raw,
    required this.canvasPos,
    this.canvasPosDelta, // Add this parameter
  }) : key = null;

  InputEvent.key({
    required this.type,
    required this.raw, // This will now be a KeyEvent instead of RawKeyEvent
    required this.key,
  })  : canvasPos = null,
        canvasPosDelta = null;
}
