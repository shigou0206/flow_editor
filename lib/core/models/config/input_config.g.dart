// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InputConfigImpl _$$InputConfigImplFromJson(Map<String, dynamic> json) =>
    _$InputConfigImpl(
      enablePan: json['enablePan'] as bool? ?? true,
      enableZoom: json['enableZoom'] as bool? ?? true,
      enableNodeDrag: json['enableNodeDrag'] as bool? ?? true,
      enableEdgeDraw: json['enableEdgeDraw'] as bool? ?? true,
      enableMarqueeSelect: json['enableMarqueeSelect'] as bool? ?? false,
      enableKeyDelete: json['enableKeyDelete'] as bool? ?? true,
      enableKeyCopyPaste: json['enableKeyCopyPaste'] as bool? ?? true,
      enableKeyUndoRedo: json['enableKeyUndoRedo'] as bool? ?? true,
    );

Map<String, dynamic> _$$InputConfigImplToJson(_$InputConfigImpl instance) =>
    <String, dynamic>{
      'enablePan': instance.enablePan,
      'enableZoom': instance.enableZoom,
      'enableNodeDrag': instance.enableNodeDrag,
      'enableEdgeDraw': instance.enableEdgeDraw,
      'enableMarqueeSelect': instance.enableMarqueeSelect,
      'enableKeyDelete': instance.enableKeyDelete,
      'enableKeyCopyPaste': instance.enableKeyCopyPaste,
      'enableKeyUndoRedo': instance.enableKeyUndoRedo,
    };
