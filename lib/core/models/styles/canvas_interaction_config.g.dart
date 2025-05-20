// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_interaction_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasInteractionConfigImpl _$$CanvasInteractionConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$CanvasInteractionConfigImpl(
      snapToGrid: json['snapToGrid'] as bool? ?? true,
      showGuides: json['showGuides'] as bool? ?? true,
      minScale: (json['minScale'] as num?)?.toDouble() ?? 0.1,
      maxScale: (json['maxScale'] as num?)?.toDouble() ?? 10.0,
      enablePan: json['enablePan'] as bool? ?? true,
      enableZoom: json['enableZoom'] as bool? ?? true,
      enableMarqueeSelect: json['enableMarqueeSelect'] as bool? ?? true,
      dropOnEdgeOnly: json['dropOnEdgeOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$$CanvasInteractionConfigImplToJson(
        _$CanvasInteractionConfigImpl instance) =>
    <String, dynamic>{
      'snapToGrid': instance.snapToGrid,
      'showGuides': instance.showGuides,
      'minScale': instance.minScale,
      'maxScale': instance.maxScale,
      'enablePan': instance.enablePan,
      'enableZoom': instance.enableZoom,
      'enableMarqueeSelect': instance.enableMarqueeSelect,
      'dropOnEdgeOnly': instance.dropOnEdgeOnly,
    };
