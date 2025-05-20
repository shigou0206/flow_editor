import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/enums/canvas_interaction_mode.dart';
import 'package:flow_editor/core/models/enums/execution_status.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';

part 'canvas_state.freezed.dart';
part 'canvas_state.g.dart';

@freezed
class CanvasState with _$CanvasState {
  const CanvasState._();

  const factory CanvasState({
    @OffsetConverter() @Default(Offset.zero) Offset offset,
    @Default(1.0) double scale,
    @Default(CanvasInteractionMode.panCanvas)
    CanvasInteractionMode interactionMode,
    @Default(CanvasVisualConfig()) CanvasVisualConfig visualConfig,
    @Default(CanvasInteractionConfig())
    CanvasInteractionConfig interactionConfig,
    @Default(1) int version,
    String? focusItemId,
    @Default(WorkflowStatus.pending) WorkflowStatus workflowStatus,
    Map<String, dynamic>? data,
  }) = _CanvasState;

  factory CanvasState.fromJson(Map<String, dynamic> json) =>
      _$CanvasStateFromJson(json);
}
