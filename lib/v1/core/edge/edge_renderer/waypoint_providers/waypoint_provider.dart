import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';

abstract class WaypointProvider {
  List<Offset>? getWaypoints(EdgeModel edge);
}
