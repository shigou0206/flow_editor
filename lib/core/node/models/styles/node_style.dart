class NodeStyle {
  final String? fillColorHex; // e.g. "#RRGGBB" or "#AARRGGBB"
  final String? borderColorHex; // e.g. "#FF00FF"
  final double borderWidth;
  final double borderRadius;

  const NodeStyle({
    this.fillColorHex,
    this.borderColorHex,
    this.borderWidth = 1.0,
    this.borderRadius = 4.0,
  });

  factory NodeStyle.fromJson(Map<String, dynamic> json) {
    return NodeStyle(
      fillColorHex: json['fillColorHex'] as String?,
      borderColorHex: json['borderColorHex'] as String?,
      borderWidth: (json['borderWidth'] as num?)?.toDouble() ?? 1.0,
      borderRadius: (json['borderRadius'] as num?)?.toDouble() ?? 4.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fillColorHex': fillColorHex,
      'borderColorHex': borderColorHex,
      'borderWidth': borderWidth,
      'borderRadius': borderRadius,
    };
  }
}
