import 'package:flutter/material.dart';

class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);

  factory Point.fromOffset(Offset offset) => Point(offset.dx, offset.dy);

  Offset toOffset() => Offset(x, y);

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        (json['x'] as num).toDouble(),
        (json['y'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {'x': x, 'y': y};

  Point copyWith({double? x, double? y}) => Point(
        x ?? this.x,
        y ?? this.y,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Point(x: $x, y: $y)';
}
