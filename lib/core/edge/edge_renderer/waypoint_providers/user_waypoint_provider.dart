import 'package:flutter/material.dart';
import 'waypoint_provider.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

class UserWaypointProvider implements WaypointProvider {
  @override
  List<Offset>? getWaypoints(EdgeModel edge) {
    return edge.waypoints?.map((p) => Offset(p[0], p[1])).toList();
  }
}
