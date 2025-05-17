import 'package:flutter/material.dart';

/// ICanvasController：用于对画布进行平移/缩放/视图适配 等操作，
/// 以及对节点、边的拖拽/删除等交互操作。
abstract class ICanvasController {
  void onTapDown(BuildContext context, TapDownDetails details);

  void onPanStart(BuildContext context, DragStartDetails details);

  void onPanUpdate(DragUpdateDetails details);

  void onPanEnd(DragEndDetails details);
}
