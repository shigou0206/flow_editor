import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'path_generator.dart';
import '../models/edge_path.dart';
import '../waypoint_providers/waypoint_provider.dart';

class WaypointPathGenerator implements PathGenerator {
  final WaypointProvider waypointProvider;

  WaypointPathGenerator(this.waypointProvider);

  @override
  EdgePath? generate(EdgeModel edge) {
    final waypoints = waypointProvider.getWaypoints(edge);
    if (waypoints == null || waypoints.length < 2) return null;

    final path = Path()..moveTo(waypoints.first.dx, waypoints.first.dy);
    for (var point in waypoints.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }

    return EdgePath(edge.id, path);
  }
}
