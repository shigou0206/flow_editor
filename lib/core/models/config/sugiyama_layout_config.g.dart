// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sugiyama_layout_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SugiyamaLayoutConfigImpl _$$SugiyamaLayoutConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$SugiyamaLayoutConfigImpl(
      groupHorizontalPadding:
          (json['groupHorizontalPadding'] as num?)?.toDouble() ?? 0.0,
      groupVerticalPadding:
          (json['groupVerticalPadding'] as num?)?.toDouble() ?? 0.0,
      nodeMarginX: (json['nodeMarginX'] as num?)?.toDouble() ?? 20.0,
      nodeMarginY: (json['nodeMarginY'] as num?)?.toDouble() ?? 20.0,
      rankDir: json['rankDir'] as String? ?? 'TB',
      ranker: json['ranker'] as String? ?? 'network-simplex',
      emptyGroupSize: json['emptyGroupSize'] == null
          ? const Size(80, 60)
          : const SizeConverter()
              .fromJson(json['emptyGroupSize'] as Map<String, dynamic>),
      compactTop: json['compactTop'] as bool? ?? true,
      compactBottom: json['compactBottom'] as bool? ?? false,
      compactLeft: json['compactLeft'] as bool? ?? false,
      compactRight: json['compactRight'] as bool? ?? false,
    );

Map<String, dynamic> _$$SugiyamaLayoutConfigImplToJson(
        _$SugiyamaLayoutConfigImpl instance) =>
    <String, dynamic>{
      'groupHorizontalPadding': instance.groupHorizontalPadding,
      'groupVerticalPadding': instance.groupVerticalPadding,
      'nodeMarginX': instance.nodeMarginX,
      'nodeMarginY': instance.nodeMarginY,
      'rankDir': instance.rankDir,
      'ranker': instance.ranker,
      'emptyGroupSize': const SizeConverter().toJson(instance.emptyGroupSize),
      'compactTop': instance.compactTop,
      'compactBottom': instance.compactBottom,
      'compactLeft': instance.compactLeft,
      'compactRight': instance.compactRight,
    };
