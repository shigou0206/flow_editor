import 'package:flutter/material.dart';

abstract class CanvasBehavior {
  void onTapDown(BuildContext context, TapDownDetails details);

  void onPanStart(BuildContext context, DragStartDetails details);

  void onPanUpdate(DragUpdateDetails details);

  void onPanEnd(DragEndDetails details);
}
