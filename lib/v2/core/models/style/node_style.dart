import 'package:equatable/equatable.dart';

class NodeStyle extends Equatable {
  final String? fillColorHex; // e.g. "#RRGGBB" or "#AARRGGBB"
  final String? borderColorHex; // e.g. "#FF00FF"
  final double borderWidth;
  final double borderRadius;

  const NodeStyle({
    this.fillColorHex = '#00FF00',
    this.borderColorHex = '#FFFF00',
    this.borderWidth = 1.0,
    this.borderRadius = 4.0,
  });

  factory NodeStyle.fromJson(Map<String, dynamic> json) {
    return NodeStyle(
      fillColorHex: json['fillColorHex'] as String? ?? '#00FF00',
      borderColorHex: json['borderColorHex'] as String? ?? '#FFFF00',
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

  @override
  List<Object?> get props =>
      [fillColorHex, borderColorHex, borderWidth, borderRadius];
}
