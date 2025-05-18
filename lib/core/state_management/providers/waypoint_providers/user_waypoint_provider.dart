import 'package:flutter/material.dart';
import 'waypoint_provider.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class UserWaypointProvider implements WaypointProvider {
  @override
  List<Offset>? getWaypoints(EdgeModel edge) {
    return edge.waypoints;
  }
}
