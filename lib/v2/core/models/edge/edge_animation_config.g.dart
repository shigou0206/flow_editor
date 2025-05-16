// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_animation_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$EdgeAnimationConfigToJson(
        EdgeAnimationConfig instance) =>
    <String, dynamic>{
      'animate': instance.animate,
      'animationType': instance.animationType,
      'animationSpeed': instance.animationSpeed,
      'animationPhase': instance.animationPhase,
      'animationColorHex': instance.animationColorHex,
      'animateDash': instance.animateDash,
      'dashFlowPhase': instance.dashFlowPhase,
      'dashFlowSpeed': instance.dashFlowSpeed,
    };

_$EdgeAnimationConfigImpl _$$EdgeAnimationConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$EdgeAnimationConfigImpl(
      animate: json['animate'] as bool? ?? false,
      animationType: json['animationType'] as String?,
      animationSpeed: (json['animationSpeed'] as num?)?.toDouble(),
      animationPhase: (json['animationPhase'] as num?)?.toDouble(),
      animationColorHex: json['animationColorHex'] as String?,
      animateDash: json['animateDash'] as bool? ?? false,
      dashFlowPhase: (json['dashFlowPhase'] as num?)?.toDouble(),
      dashFlowSpeed: (json['dashFlowSpeed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$EdgeAnimationConfigImplToJson(
        _$EdgeAnimationConfigImpl instance) =>
    <String, dynamic>{
      'animate': instance.animate,
      'animationType': instance.animationType,
      'animationSpeed': instance.animationSpeed,
      'animationPhase': instance.animationPhase,
      'animationColorHex': instance.animationColorHex,
      'animateDash': instance.animateDash,
      'dashFlowPhase': instance.dashFlowPhase,
      'dashFlowSpeed': instance.dashFlowSpeed,
    };
