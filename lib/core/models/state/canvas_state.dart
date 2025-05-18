import 'dart:ui';
import 'package:flow_editor/core/models/enums/canvas_interaction_mode.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';

class CanvasState {
  final Offset offset;
  final double scale;
  final WorkflowMode workflowMode;
  final CanvasInteractionMode interactionMode;
  final CanvasVisualConfig visualConfig;
  final CanvasInteractionConfig interactionConfig;
  final CanvasInteractionState interactionState;
  final int version;
  final String? focusItemId;

  const CanvasState({
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.workflowMode = WorkflowMode.generic,
    this.interactionMode = CanvasInteractionMode.panCanvas,
    this.visualConfig = const CanvasVisualConfig(),
    this.interactionConfig = const CanvasInteractionConfig(),
    this.interactionState = const CanvasInteractionState(),
    this.version = 1,
    this.focusItemId,
  });

  CanvasState copyWith({
    Offset? offset,
    double? scale,
    WorkflowMode? workflowMode,
    CanvasInteractionMode? interactionMode,
    CanvasVisualConfig? visualConfig,
    CanvasInteractionConfig? interactionConfig,
    CanvasInteractionState? interactionState,
    int? version,
    String? focusItemId,
  }) {
    final effectiveInteractionConfig =
        interactionConfig ?? this.interactionConfig;
    return CanvasState(
      offset: offset ?? this.offset,
      scale: (scale ?? this.scale).clamp(
        effectiveInteractionConfig.minScale,
        effectiveInteractionConfig.maxScale,
      ),
      workflowMode: workflowMode ?? this.workflowMode,
      interactionMode: interactionMode ?? this.interactionMode,
      visualConfig: visualConfig ?? this.visualConfig,
      interactionConfig: effectiveInteractionConfig,
      interactionState: interactionState ?? this.interactionState,
      version: version ?? this.version,
      focusItemId: focusItemId ?? this.focusItemId,
    );
  }

  Map<String, dynamic> toJson() => {
        'offsetX': offset.dx,
        'offsetY': offset.dy,
        'scale': scale,
        'workflowMode': workflowMode.name,
        'interactionMode': interactionMode.name,
        'visualConfig': visualConfig.toJson(),
        'interactionConfig': interactionConfig.toJson(),
        'interactionState': interactionState.toJson(),
        'version': version,
        'focusItemId': focusItemId,
      };

  factory CanvasState.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value, [double fallback = 0.0]) {
      double? result;
      if (value is num) {
        result = value.toDouble();
      } else if (value is String) {
        result = double.tryParse(value);
      }

      if (result == null || result.isNaN || result.isInfinite) {
        return fallback;
      }
      return result;
    }

    int parseInt(dynamic value, [int fallback = 1]) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? fallback;
      return fallback;
    }

    final dx = parseDouble(json['offsetX']);
    final dy = parseDouble(json['offsetY']);
    final scale = parseDouble(json['scale'], 1.0);
    final version = parseInt(json['version'], 1);

    final workflowModeStr = json['workflowMode'] as String? ?? 'generic';
    final workflowMode = WorkflowMode.values.firstWhere(
      (m) => m.name == workflowModeStr,
      orElse: () => WorkflowMode.generic,
    );

    final interactionModeStr =
        json['interactionMode'] as String? ?? 'panCanvas';
    final interactionMode = CanvasInteractionMode.values.firstWhere(
      (m) => m.name == interactionModeStr,
      orElse: () => CanvasInteractionMode.panCanvas,
    );

    return CanvasState(
      offset: Offset(dx, dy),
      scale: scale,
      workflowMode: workflowMode,
      interactionMode: interactionMode,
      visualConfig: json['visualConfig'] is Map
          ? CanvasVisualConfig.fromJson(json['visualConfig'])
          : const CanvasVisualConfig(),
      interactionConfig: json['interactionConfig'] is Map
          ? CanvasInteractionConfig.fromJson(json['interactionConfig'])
          : const CanvasInteractionConfig(),
      interactionState: json['interactionState'] is Map
          ? CanvasInteractionState.fromJson(json['interactionState'])
          : const CanvasInteractionState(),
      version: version,
      focusItemId: json['focusItemId'] as String?,
    );
  }
}

class MultiWorkflowCanvasState {
  final String activeWorkflowId;
  final Map<String, CanvasState> workflows;
  final String? hoveredEdgeId;

  const MultiWorkflowCanvasState({
    required this.activeWorkflowId,
    required this.workflows,
    this.hoveredEdgeId,
  });

  CanvasState get activeState => workflows[activeWorkflowId]!;

  MultiWorkflowCanvasState copyWith({
    String? activeWorkflowId,
    Map<String, CanvasState>? workflows,
    String? hoveredEdgeId,
  }) {
    return MultiWorkflowCanvasState(
      activeWorkflowId: activeWorkflowId ?? this.activeWorkflowId,
      workflows: workflows ?? this.workflows,
      hoveredEdgeId: hoveredEdgeId ?? this.hoveredEdgeId,
    );
  }

  Map<String, dynamic> toJson() => {
        'activeWorkflowId': activeWorkflowId,
        'hoveredEdgeId': hoveredEdgeId,
        'workflows':
            workflows.map((key, state) => MapEntry(key, state.toJson())),
      };

  factory MultiWorkflowCanvasState.fromJson(Map<String, dynamic> json) {
    final workflowsJson = json['workflows'] as Map<String, dynamic>? ?? {};
    final workflows = workflowsJson.map(
      (key, stateJson) => MapEntry(key, CanvasState.fromJson(stateJson)),
    );
    return MultiWorkflowCanvasState(
      activeWorkflowId: json['activeWorkflowId'] as String,
      hoveredEdgeId: json['hoveredEdgeId'] as String?,
      workflows: workflows,
    );
  }
}
