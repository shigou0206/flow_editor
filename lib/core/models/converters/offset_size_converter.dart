import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) =>
      Offset((json['dx'] as num).toDouble(), (json['dy'] as num).toDouble());

  @override
  Map<String, dynamic> toJson(Offset object) =>
      {'dx': object.dx, 'dy': object.dy};
}

class SizeConverter implements JsonConverter<Size, Map<String, dynamic>> {
  const SizeConverter();

  @override
  Size fromJson(Map<String, dynamic> json) => Size(
      (json['width'] as num).toDouble(), (json['height'] as num).toDouble());

  @override
  Map<String, dynamic> toJson(Size object) =>
      {'width': object.width, 'height': object.height};
}

class OffsetListConverter implements JsonConverter<List<Offset>?, List?> {
  const OffsetListConverter();

  @override
  List<Offset>? fromJson(List? json) {
    if (json == null) return null;
    return json.map<Offset>((e) {
      if (e is List && e.length == 2) {
        return Offset((e[0] as num).toDouble(), (e[1] as num).toDouble());
      }
      return Offset.zero;
    }).toList();
  }

  @override
  List? toJson(List<Offset>? object) {
    return object?.map((e) => [e.dx, e.dy]).toList();
  }
}
