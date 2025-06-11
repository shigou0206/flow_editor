import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cursor_behavior_config.freezed.dart';

@freezed
class CursorBehaviorConfig with _$CursorBehaviorConfig {
  const factory CursorBehaviorConfig({
    MouseCursor? idle,
    MouseCursor? panCanvas,
    MouseCursor? dragNode,
    MouseCursor? dragEdge,
    MouseCursor? dragWaypoint,
    MouseCursor? selectingArea,
    MouseCursor? insertingNode,
    MouseCursor? insertNodeToEdge,
    MouseCursor? resizingNode,
    MouseCursor? hoveringNode,
    MouseCursor? hoveringAnchor,
    MouseCursor? hoveringEdge,
    MouseCursor? contextMenuOpen,
    MouseCursor? insertingNodePreview,
    MouseCursor? insertingGroupPreview,
  }) = _CursorBehaviorConfig;

  factory CursorBehaviorConfig.defaultConfig() => const CursorBehaviorConfig(
        idle: SystemMouseCursors.basic,
        panCanvas: SystemMouseCursors.grab,
        dragNode: SystemMouseCursors.grabbing,
        dragEdge: SystemMouseCursors.precise,
        dragWaypoint: SystemMouseCursors.precise,
        selectingArea: SystemMouseCursors.cell,
        insertingNode: SystemMouseCursors.copy,
        insertNodeToEdge: SystemMouseCursors.copy,
        resizingNode: SystemMouseCursors.resizeUpDown,
        hoveringNode: SystemMouseCursors.click,
        hoveringAnchor: SystemMouseCursors.click,
        hoveringEdge: SystemMouseCursors.click,
        contextMenuOpen: SystemMouseCursors.forbidden,
        insertingNodePreview: SystemMouseCursors.copy,
        insertingGroupPreview: SystemMouseCursors.copy,
      );
}
