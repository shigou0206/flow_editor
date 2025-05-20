import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flutter/material.dart';
import '../../models/edge_path.dart';

abstract class PathGenerator {
  EdgePath? generate(EdgeModel edge);
  EdgePath? generateGhost(EdgeModel edge, Offset draggingEnd);
}
