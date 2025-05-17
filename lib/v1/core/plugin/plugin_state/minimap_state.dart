class MinimapState {
  final double width;
  final double height;
  final double scale;
  final double offsetX;
  final double offsetY;

  const MinimapState({
    this.width = 180,
    this.height = 120,
    this.scale = 1.0,
    this.offsetX = 0,
    this.offsetY = 0,
  });

  MinimapState copyWith({
    double? width,
    double? height,
    double? scale,
    double? offsetX,
    double? offsetY,
  }) {
    return MinimapState(
      width: width ?? this.width,
      height: height ?? this.height,
      scale: scale ?? this.scale,
      offsetX: offsetX ?? this.offsetX,
      offsetY: offsetY ?? this.offsetY,
    );
  }
}
