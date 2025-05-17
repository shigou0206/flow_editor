import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/models/canvas_geom.dart';
import 'package:flow_editor/core/state_management/models/canvas_visual.dart';
import 'package:flow_editor/core/state_management/models/hover_state.dart';
import 'package:flow_editor/core/state_management/models/selection_state.dart';
import 'package:flow_editor/core/state_management/models/drag_state.dart';
import 'package:flow_editor/core/state_management/notifiers/canvas_geom_notifier.dart';
import 'package:flow_editor/core/state_management/notifiers/canvas_visual_notifier.dart';

/// family key = workflowId

// 几何
final canvasGeomProvider =
    StateNotifierProvider.family<CanvasGeomNotifier, CanvasGeom, String>(
  (ref, wf) => CanvasGeomNotifier(),
);

// 外观
final canvasVisualProvider =
    StateNotifierProvider.family<CanvasVisualNotifier, CanvasVisual, String>(
  (ref, wf) => CanvasVisualNotifier(),
);

// Hover
final hoverProvider = StateProvider.family<HoverState, String>(
  (ref, wf) => const HoverState(),
);

// Selection
final selectionProvider = StateProvider.family<SelectionState, String>(
  (ref, wf) => const SelectionState(),
);

// Drag / Ghost Edge
final dragProvider = StateProvider.family<DragState, String>(
  (ref, wf) => const DragState(),
);
