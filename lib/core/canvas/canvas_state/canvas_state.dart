import 'dart:ui';
import 'package:flow_editor/core/canvas/models/canvas_interaction_mode.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/models/canvas_interaction_config.dart';

/// 单个画布状态（单个workflow）
class CanvasState {
  final Offset offset;
  final double scale;
  final CanvasInteractionMode mode;
  final CanvasVisualConfig visualConfig;
  final CanvasInteractionConfig interactionConfig;
  final int version;
  final String? focusItemId;

  const CanvasState({
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.mode = CanvasInteractionMode.panCanvas,
    this.visualConfig = const CanvasVisualConfig(),
    this.interactionConfig = const CanvasInteractionConfig(),
    this.version = 1,
    this.focusItemId,
  });

  CanvasState copyWith({
    Offset? offset,
    double? scale,
    CanvasInteractionMode? mode,
    CanvasVisualConfig? visualConfig,
    CanvasInteractionConfig? interactionConfig,
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
      mode: mode ?? this.mode,
      visualConfig: visualConfig ?? this.visualConfig,
      interactionConfig: effectiveInteractionConfig,
      version: version ?? this.version,
      focusItemId: focusItemId ?? this.focusItemId,
    );
  }

  Map<String, dynamic> toJson() => {
        'offsetX': offset.dx,
        'offsetY': offset.dy,
        'scale': scale,
        'mode': mode.name,
        'visualConfig': visualConfig.toJson(),
        'interactionConfig': interactionConfig.toJson(),
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

    final modeStr = json['mode'] as String? ?? 'panCanvas';
    final mode = CanvasInteractionMode.values.firstWhere(
      (m) => m.name == modeStr,
      orElse: () => CanvasInteractionMode.panCanvas,
    );

    return CanvasState(
      offset: Offset(dx, dy),
      scale: scale,
      mode: mode,
      visualConfig: json['visualConfig'] is Map
          ? CanvasVisualConfig.fromJson(json['visualConfig'])
          : CanvasVisualConfig(),
      interactionConfig: json['interactionConfig'] is Map
          ? CanvasInteractionConfig.fromJson(json['interactionConfig'])
          : CanvasInteractionConfig(),
      version: version,
      focusItemId: json['focusItemId'] as String?,
    );
  }
}

/// 支持多workflow的状态管理
class MultiWorkflowCanvasState {
  final Map<String, CanvasState> workflows;
  final String activeWorkflowId;

  const MultiWorkflowCanvasState({
    required this.activeWorkflowId,
    this.workflows = const {},
  });

  CanvasState get activeState =>
      workflows[activeWorkflowId] ?? const CanvasState();

  MultiWorkflowCanvasState copyWith({
    Map<String, CanvasState>? workflows,
    String? activeWorkflowId,
  }) {
    return MultiWorkflowCanvasState(
      workflows: workflows ?? this.workflows,
      activeWorkflowId: activeWorkflowId ?? this.activeWorkflowId,
    );
  }

  Map<String, dynamic> toJson() => {
        'activeWorkflowId': activeWorkflowId,
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
      workflows: workflows,
    );
  }
}
