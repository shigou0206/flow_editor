import 'dart:ui';

/// 画布几何：平移 & 缩放（序列化持久化）
class CanvasGeom {
  const CanvasGeom({
    this.offset = Offset.zero,
    this.scale = 1,
  });

  final Offset offset;
  final double scale;

  CanvasGeom copyWith({
    Offset? offset,
    double? scale,
    double minScale = 0.2,
    double maxScale = 3,
  }) =>
      CanvasGeom(
        offset: offset ?? this.offset,
        scale: (scale ?? this.scale).clamp(minScale, maxScale),
      );

  // --- JSON ---
  Map<String, dynamic> toJson() => {
        'dx': offset.dx,
        'dy': offset.dy,
        'scale': scale,
      };

  factory CanvasGeom.fromJson(Map j) => CanvasGeom(
        offset: Offset(
          (j['dx'] ?? 0).toDouble(),
          (j['dy'] ?? 0).toDouble(),
        ),
        scale: (j['scale'] ?? 1).toDouble(),
      );
}
