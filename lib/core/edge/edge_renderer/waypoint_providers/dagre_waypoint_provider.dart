import 'package:flutter/material.dart';
import 'waypoint_provider.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

class DagreWaypointProvider implements WaypointProvider {
  final Map<String, List<Offset>> _waypointsCache;

  DagreWaypointProvider(this._waypointsCache);

  @override
  List<Offset>? getWaypoints(EdgeModel edge) {
    return _waypointsCache[edge.id];
  }
}
