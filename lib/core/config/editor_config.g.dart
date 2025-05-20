// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditorConfigImpl _$$EditorConfigImplFromJson(Map<String, dynamic> json) =>
    _$EditorConfigImpl(
      hitTestTolerance: json['hitTestTolerance'] == null
          ? const HitTestTolerance()
          : HitTestTolerance.fromJson(
              json['hitTestTolerance'] as Map<String, dynamic>),
      enableMultiSelect: json['enableMultiSelect'] as bool? ?? true,
      enableGroupNode: json['enableGroupNode'] as bool? ?? true,
      enableUndoRedo: json['enableUndoRedo'] as bool? ?? true,
      enableClipboard: json['enableClipboard'] as bool? ?? true,
      enableKeyboardShortcuts: json['enableKeyboardShortcuts'] as bool? ?? true,
    );

Map<String, dynamic> _$$EditorConfigImplToJson(_$EditorConfigImpl instance) =>
    <String, dynamic>{
      'hitTestTolerance': instance.hitTestTolerance,
      'enableMultiSelect': instance.enableMultiSelect,
      'enableGroupNode': instance.enableGroupNode,
      'enableUndoRedo': instance.enableUndoRedo,
      'enableClipboard': instance.enableClipboard,
      'enableKeyboardShortcuts': instance.enableKeyboardShortcuts,
    };
