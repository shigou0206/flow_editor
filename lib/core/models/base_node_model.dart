import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class BaseNodeModel {
  final String id;
  Offset position;
  Size size;

  BaseNodeModel({
    required this.id,
    required this.position,
    required this.size,
  });

  Rect get rect =>
      Rect.fromLTWH(position.dx, position.dy, size.width, size.height);

  void doLayout();

  BaseNodeModel copyWith({Offset? position, Size? size});
}
