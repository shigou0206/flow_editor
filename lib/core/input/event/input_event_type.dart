enum InputEventType {
  // Pointer interaction (鼠标或触摸)
  pointerDown,
  pointerMove,
  pointerUp,
  pointerHover,
  pointerEnter,
  pointerExit,
  pointerCancel,
  pointerSignal,

  // Tap and gesture interactions (手势)
  tap,
  doubleTap,
  longPress,

  // Drag interactions (拖拽)
  dragStart,
  dragUpdate,
  dragEnd,

  // Keyboard interactions (键盘)
  keyDown,
  keyUp,
  keyRepeat,
}
