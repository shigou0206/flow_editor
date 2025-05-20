class InputConfig {
  final bool enablePan;
  final bool enableZoom;
  final bool enableNodeDrag;
  final bool enableEdgeDraw;
  final bool enableMarqueeSelect;
  final bool enableKeyDelete;
  final bool enableKeyCopyPaste;
  final bool enableKeyUndoRedo;

  const InputConfig({
    this.enablePan = true,
    this.enableZoom = true,
    this.enableNodeDrag = true,
    this.enableEdgeDraw = true,
    this.enableMarqueeSelect = true,
    this.enableKeyDelete = true,
    this.enableKeyCopyPaste = true,
    this.enableKeyUndoRedo = true,
  });
}
