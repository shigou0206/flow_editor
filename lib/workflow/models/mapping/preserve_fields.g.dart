// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preserve_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllPreserveFieldsImpl _$$AllPreserveFieldsImplFromJson(
        Map<String, dynamic> json) =>
    _$AllPreserveFieldsImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AllPreserveFieldsImplToJson(
        _$AllPreserveFieldsImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$NonePreserveFieldsImpl _$$NonePreserveFieldsImplFromJson(
        Map<String, dynamic> json) =>
    _$NonePreserveFieldsImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NonePreserveFieldsImplToJson(
        _$NonePreserveFieldsImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SomePreserveFieldsImpl _$$SomePreserveFieldsImplFromJson(
        Map<String, dynamic> json) =>
    _$SomePreserveFieldsImpl(
      (json['fields'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SomePreserveFieldsImplToJson(
        _$SomePreserveFieldsImpl instance) =>
    <String, dynamic>{
      'fields': instance.fields,
      'runtimeType': instance.$type,
    };
