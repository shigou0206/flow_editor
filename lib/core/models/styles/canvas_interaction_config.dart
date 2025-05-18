/// CanvasInteractionConfig: 画布交互相关的配置（缩放范围、平移范围等）
class CanvasInteractionConfig {
  final bool snapToGrid;
  final bool showGuides;
  final double minScale;
  final double maxScale;
  final bool enablePan;
  final bool enableZoom;
  final bool enableMarqueeSelect;
  final bool dropOnEdgeOnly;

  const CanvasInteractionConfig({
    this.snapToGrid = true,
    this.showGuides = true,
    this.minScale = 0.1,
    this.maxScale = 10.0,
    this.enablePan = true,
    this.enableZoom = true,
    this.enableMarqueeSelect = true,
    this.dropOnEdgeOnly = false,
  });

  /// 序列化
  Map<String, dynamic> toJson() => {
        'snapToGrid': snapToGrid,
        'showGuides': showGuides,
        'minScale': minScale,
        'maxScale': maxScale,
        'enablePan': enablePan,
        'enableZoom': enableZoom,
        'enableMarqueeSelect': enableMarqueeSelect,
        'dropOnEdgeOnly': dropOnEdgeOnly,
      };

  /// 反序列化
  factory CanvasInteractionConfig.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value, double fallback) {
      if (value is num) return value.toDouble();
      if (value is String) {
        final d = double.tryParse(value);
        if (d != null && !d.isNaN && !d.isInfinite) return d;
      }
      return fallback;
    }

    return CanvasInteractionConfig(
      snapToGrid: json['snapToGrid'] as bool? ?? true,
      showGuides: json['showGuides'] as bool? ?? true,
      minScale: parseDouble(json['minScale'], 0.1),
      maxScale: parseDouble(json['maxScale'], 10.0),
      enablePan: json['enablePan'] as bool? ?? true,
      enableZoom: json['enableZoom'] as bool? ?? true,
      enableMarqueeSelect: json['enableMarqueeSelect'] as bool? ?? true,
      dropOnEdgeOnly: json['dropOnEdgeOnly'] as bool? ?? false,
    );
  }

  /// 拷贝并可选更新部分字段
  CanvasInteractionConfig copyWith({
    bool? snapToGrid,
    bool? showGuides,
    double? minScale,
    double? maxScale,
    bool? enablePan,
    bool? enableZoom,
    bool? enableMarqueeSelect,
    bool? dropOnEdgeOnly,
  }) {
    return CanvasInteractionConfig(
      snapToGrid: snapToGrid ?? this.snapToGrid,
      showGuides: showGuides ?? this.showGuides,
      minScale: minScale ?? this.minScale,
      maxScale: maxScale ?? this.maxScale,
      enablePan: enablePan ?? this.enablePan,
      enableZoom: enableZoom ?? this.enableZoom,
      enableMarqueeSelect: enableMarqueeSelect ?? this.enableMarqueeSelect,
      dropOnEdgeOnly: dropOnEdgeOnly ?? this.dropOnEdgeOnly,
    );
  }
}
