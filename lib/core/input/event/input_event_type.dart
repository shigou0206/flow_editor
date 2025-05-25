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

  pointerRightClick, // 已新增 (右键点击)
  pointerRightDown, // 可选 (右键按下)
  pointerRightUp, // 可选 (右键抬起)
  pointerScroll, // 可选 (鼠标滚轮滚动)

  // Tap and gesture interactions (手势)
  tap,
  doubleTap,
  longPress,

  nodeDoubleTap, // 可选 (节点双击)
  edgeDoubleTap, // 可选 (边双击)

  // Drag interactions (拖拽)
  dragStart,
  dragUpdate,
  dragEnd,

  // Keyboard interactions (键盘)
  keyDown,
  keyUp,
  keyRepeat,

  keyCopy, // 可选 (复制快捷键)
  keyPaste, // 可选 (粘贴快捷键)
  keyCut, // 可选 (剪切快捷键)
  keyDelete, // 可选 (删除快捷键)
  keyEscape, // 可选 (Esc键事件)
}
