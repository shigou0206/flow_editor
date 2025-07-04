import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flutter/material.dart';
import '../../models/ui/edge_path.dart';

abstract class PathGenerator {
  EdgePath? generate(EdgeModel edge);
  EdgePath? generateGhost(EdgeModel edge, Offset draggingEnd);
}
