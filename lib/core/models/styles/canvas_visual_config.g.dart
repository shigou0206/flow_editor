// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_visual_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasVisualConfigImpl _$$CanvasVisualConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$CanvasVisualConfigImpl(
      backgroundColor: json['backgroundColor'] == null
          ? Colors.white
          : const ColorConverter().fromJson(json['backgroundColor'] as String),
      showGrid: json['showGrid'] as bool? ?? false,
      gridColor: json['gridColor'] == null
          ? const Color(0xffe0e0e0)
          : const ColorConverter().fromJson(json['gridColor'] as String),
      gridSpacing: (json['gridSpacing'] as num?)?.toDouble() ?? 20.0,
      width: (json['width'] as num?)?.toDouble() ?? 1000000.0,
      height: (json['height'] as num?)?.toDouble() ?? 1000000.0,
      backgroundStyle: $enumDecodeNullable(
              _$BackgroundStyleEnumMap, json['backgroundStyle']) ??
          BackgroundStyle.dots,
    );

Map<String, dynamic> _$$CanvasVisualConfigImplToJson(
        _$CanvasVisualConfigImpl instance) =>
    <String, dynamic>{
      'backgroundColor':
          const ColorConverter().toJson(instance.backgroundColor),
      'showGrid': instance.showGrid,
      'gridColor': const ColorConverter().toJson(instance.gridColor),
      'gridSpacing': instance.gridSpacing,
      'width': instance.width,
      'height': instance.height,
      'backgroundStyle': _$BackgroundStyleEnumMap[instance.backgroundStyle]!,
    };

const _$BackgroundStyleEnumMap = {
  BackgroundStyle.dots: 'dots',
  BackgroundStyle.lines: 'lines',
  BackgroundStyle.crossLines: 'crossLines',
  BackgroundStyle.clean: 'clean',
};
