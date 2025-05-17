import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/edge_model.dart';

abstract class WaypointProvider {
  List<Offset>? getWaypoints(EdgeModel edge);
}
