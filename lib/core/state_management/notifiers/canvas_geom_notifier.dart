import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/models/canvas_geom.dart';

class CanvasGeomNotifier extends StateNotifier<CanvasGeom> {
  CanvasGeomNotifier() : super(const CanvasGeom());

  void pan(Offset delta) =>
      state = state.copyWith(offset: state.offset + delta);

  void zoom(double factor) =>
      state = state.copyWith(scale: state.scale * factor);
}
