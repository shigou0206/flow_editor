import 'package:flutter/material.dart';

abstract class BaseNodeModel {
  final String id;
  double x;
  double y;
  double width;
  double height;

  BaseNodeModel({
    required this.id,
    this.x = 0,
    this.y = 0,
    this.width = 80,
    this.height = 40,
  });

  Rect get rect => Rect.fromLTWH(x, y, width, height);

  BaseNodeModel copyWith({
    double? x,
    double? y,
    double? width,
    double? height,
  });
}
