import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String colorString) {
    final hex = colorString.replaceFirst('#', '');
    final intValue = int.tryParse(hex, radix: 16);
    if (intValue != null) return Color(intValue);
    return Colors.white;
  }

  @override
  String toJson(Color color) =>
      '#${(color.alpha << 24 | color.red << 16 | color.green << 8 | color.blue).toRadixString(16).padLeft(8, '0')}';
}
