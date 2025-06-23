import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/config/cursor_behavior_config.dart';
import 'package:flow_editor/core/models/ui_state/interaction_transient_state.dart';

MouseCursor resolveCursor(
  InteractionState state,
  CursorBehaviorConfig config,
) {
  return state.map(
    idle: (_) => config.idle ?? SystemMouseCursors.basic,
    panCanvas: (_) => config.panCanvas ?? SystemMouseCursors.grab,
    dragNode: (_) => config.dragNode ?? SystemMouseCursors.grabbing,
    dragEdge: (_) => config.dragEdge ?? SystemMouseCursors.precise,
    dragWaypoint: (_) => config.dragWaypoint ?? SystemMouseCursors.precise,
    selectingArea: (_) => config.selectingArea ?? SystemMouseCursors.cell,
    insertingNode: (_) => config.insertingNode ?? SystemMouseCursors.copy,
    insertNodeToEdge: (_) =>
        config.insertNodeToEdge ?? SystemMouseCursors.precise,
    resizingNode: (_) => config.resizingNode ?? SystemMouseCursors.resizeUpDown,
    hoveringNode: (_) => config.hoveringNode ?? SystemMouseCursors.click,
    hoveringAnchor: (_) => config.hoveringAnchor ?? SystemMouseCursors.click,
    hoveringEdge: (_) => config.hoveringEdge ?? SystemMouseCursors.precise,
    contextMenuOpen: (_) =>
        config.contextMenuOpen ?? SystemMouseCursors.forbidden,
    insertingNodePreview: (_) =>
        config.insertingNodePreview ?? SystemMouseCursors.copy,
    insertingGroupPreview: (_) =>
        config.insertingGroupPreview ?? SystemMouseCursors.copy,
  );
}
