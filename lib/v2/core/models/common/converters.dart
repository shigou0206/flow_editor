import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) =>
      Offset((json['dx'] as num).toDouble(), (json['dy'] as num).toDouble());

  @override
  Map<String, dynamic> toJson(Offset offset) =>
      {'dx': offset.dx, 'dy': offset.dy};
}

class SizeConverter implements JsonConverter<Size, Map<String, dynamic>> {
  const SizeConverter();

  @override
  Size fromJson(Map<String, dynamic> json) => Size(
      (json['width'] as num).toDouble(), (json['height'] as num).toDouble());

  @override
  Map<String, dynamic> toJson(Size size) =>
      {'width': size.width, 'height': size.height};
}

class ColorHexConverter implements JsonConverter<Color?, String?> {
  const ColorHexConverter();

  @override
  Color? fromJson(String? hex) {
    if (hex == null) return null;
    String cleanHex = hex.replaceAll('#', '');
    if (cleanHex.length == 6) cleanHex = 'FF$cleanHex';
    return Color(int.parse(cleanHex, radix: 16));
  }

  @override
  String? toJson(Color? color) {
    if (color == null) return null;
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}

class DateTimeEpochConverter implements JsonConverter<DateTime?, int?> {
  const DateTimeEpochConverter();

  @override
  DateTime? fromJson(int? timestamp) {
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  int? toJson(DateTime? date) => date?.millisecondsSinceEpoch;
}
