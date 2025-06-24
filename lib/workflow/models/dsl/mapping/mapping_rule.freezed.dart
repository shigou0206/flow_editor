// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mapping_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MappingRule _$MappingRuleFromJson(Map<String, dynamic> json) {
  return _MappingRule.fromJson(json);
}

/// @nodoc
mixin _$MappingRule {
  String get key =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'type')
  MappingType get mappingType => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  String? get transform => throw _privateConstructorUsedError;
  String? get template => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;
  List<MappingRule>? get subMappings => throw _privateConstructorUsedError;
  MergeStrategy get mergeStrategy => throw _privateConstructorUsedError;
  String? get condition => throw _privateConstructorUsedError;
  List<String>? get dependsOn => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get lang => throw _privateConstructorUsedError;
  String? get expectedType => throw _privateConstructorUsedError;
  dynamic get schema => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MappingRuleCopyWith<MappingRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MappingRuleCopyWith<$Res> {
  factory $MappingRuleCopyWith(
          MappingRule value, $Res Function(MappingRule) then) =
      _$MappingRuleCopyWithImpl<$Res, MappingRule>;
  @useResult
  $Res call(
      {String key,
      @JsonKey(name: 'type') MappingType mappingType,
      String? source,
      String? transform,
      String? template,
      dynamic value,
      List<MappingRule>? subMappings,
      MergeStrategy mergeStrategy,
      String? condition,
      List<String>? dependsOn,
      String? comment,
      String? lang,
      String? expectedType,
      dynamic schema});
}

/// @nodoc
class _$MappingRuleCopyWithImpl<$Res, $Val extends MappingRule>
    implements $MappingRuleCopyWith<$Res> {
  _$MappingRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? mappingType = null,
    Object? source = freezed,
    Object? transform = freezed,
    Object? template = freezed,
    Object? value = freezed,
    Object? subMappings = freezed,
    Object? mergeStrategy = null,
    Object? condition = freezed,
    Object? dependsOn = freezed,
    Object? comment = freezed,
    Object? lang = freezed,
    Object? expectedType = freezed,
    Object? schema = freezed,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      mappingType: null == mappingType
          ? _value.mappingType
          : mappingType // ignore: cast_nullable_to_non_nullable
              as MappingType,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      transform: freezed == transform
          ? _value.transform
          : transform // ignore: cast_nullable_to_non_nullable
              as String?,
      template: freezed == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      subMappings: freezed == subMappings
          ? _value.subMappings
          : subMappings // ignore: cast_nullable_to_non_nullable
              as List<MappingRule>?,
      mergeStrategy: null == mergeStrategy
          ? _value.mergeStrategy
          : mergeStrategy // ignore: cast_nullable_to_non_nullable
              as MergeStrategy,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      dependsOn: freezed == dependsOn
          ? _value.dependsOn
          : dependsOn // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      lang: freezed == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedType: freezed == expectedType
          ? _value.expectedType
          : expectedType // ignore: cast_nullable_to_non_nullable
              as String?,
      schema: freezed == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MappingRuleImplCopyWith<$Res>
    implements $MappingRuleCopyWith<$Res> {
  factory _$$MappingRuleImplCopyWith(
          _$MappingRuleImpl value, $Res Function(_$MappingRuleImpl) then) =
      __$$MappingRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String key,
      @JsonKey(name: 'type') MappingType mappingType,
      String? source,
      String? transform,
      String? template,
      dynamic value,
      List<MappingRule>? subMappings,
      MergeStrategy mergeStrategy,
      String? condition,
      List<String>? dependsOn,
      String? comment,
      String? lang,
      String? expectedType,
      dynamic schema});
}

/// @nodoc
class __$$MappingRuleImplCopyWithImpl<$Res>
    extends _$MappingRuleCopyWithImpl<$Res, _$MappingRuleImpl>
    implements _$$MappingRuleImplCopyWith<$Res> {
  __$$MappingRuleImplCopyWithImpl(
      _$MappingRuleImpl _value, $Res Function(_$MappingRuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? mappingType = null,
    Object? source = freezed,
    Object? transform = freezed,
    Object? template = freezed,
    Object? value = freezed,
    Object? subMappings = freezed,
    Object? mergeStrategy = null,
    Object? condition = freezed,
    Object? dependsOn = freezed,
    Object? comment = freezed,
    Object? lang = freezed,
    Object? expectedType = freezed,
    Object? schema = freezed,
  }) {
    return _then(_$MappingRuleImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      mappingType: null == mappingType
          ? _value.mappingType
          : mappingType // ignore: cast_nullable_to_non_nullable
              as MappingType,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      transform: freezed == transform
          ? _value.transform
          : transform // ignore: cast_nullable_to_non_nullable
              as String?,
      template: freezed == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      subMappings: freezed == subMappings
          ? _value._subMappings
          : subMappings // ignore: cast_nullable_to_non_nullable
              as List<MappingRule>?,
      mergeStrategy: null == mergeStrategy
          ? _value.mergeStrategy
          : mergeStrategy // ignore: cast_nullable_to_non_nullable
              as MergeStrategy,
      condition: freezed == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      dependsOn: freezed == dependsOn
          ? _value._dependsOn
          : dependsOn // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      lang: freezed == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedType: freezed == expectedType
          ? _value.expectedType
          : expectedType // ignore: cast_nullable_to_non_nullable
              as String?,
      schema: freezed == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MappingRuleImpl implements _MappingRule {
  const _$MappingRuleImpl(
      {required this.key,
      @JsonKey(name: 'type') required this.mappingType,
      this.source,
      this.transform,
      this.template,
      this.value,
      final List<MappingRule>? subMappings,
      this.mergeStrategy = MergeStrategy.overwrite,
      this.condition,
      final List<String>? dependsOn,
      this.comment,
      this.lang,
      this.expectedType,
      this.schema})
      : _subMappings = subMappings,
        _dependsOn = dependsOn;

  factory _$MappingRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$MappingRuleImplFromJson(json);

  @override
  final String key;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'type')
  final MappingType mappingType;
  @override
  final String? source;
  @override
  final String? transform;
  @override
  final String? template;
  @override
  final dynamic value;
  final List<MappingRule>? _subMappings;
  @override
  List<MappingRule>? get subMappings {
    final value = _subMappings;
    if (value == null) return null;
    if (_subMappings is EqualUnmodifiableListView) return _subMappings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final MergeStrategy mergeStrategy;
  @override
  final String? condition;
  final List<String>? _dependsOn;
  @override
  List<String>? get dependsOn {
    final value = _dependsOn;
    if (value == null) return null;
    if (_dependsOn is EqualUnmodifiableListView) return _dependsOn;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? comment;
  @override
  final String? lang;
  @override
  final String? expectedType;
  @override
  final dynamic schema;

  @override
  String toString() {
    return 'MappingRule(key: $key, mappingType: $mappingType, source: $source, transform: $transform, template: $template, value: $value, subMappings: $subMappings, mergeStrategy: $mergeStrategy, condition: $condition, dependsOn: $dependsOn, comment: $comment, lang: $lang, expectedType: $expectedType, schema: $schema)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MappingRuleImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.mappingType, mappingType) ||
                other.mappingType == mappingType) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.transform, transform) ||
                other.transform == transform) &&
            (identical(other.template, template) ||
                other.template == template) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality()
                .equals(other._subMappings, _subMappings) &&
            (identical(other.mergeStrategy, mergeStrategy) ||
                other.mergeStrategy == mergeStrategy) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            const DeepCollectionEquality()
                .equals(other._dependsOn, _dependsOn) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.expectedType, expectedType) ||
                other.expectedType == expectedType) &&
            const DeepCollectionEquality().equals(other.schema, schema));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      key,
      mappingType,
      source,
      transform,
      template,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(_subMappings),
      mergeStrategy,
      condition,
      const DeepCollectionEquality().hash(_dependsOn),
      comment,
      lang,
      expectedType,
      const DeepCollectionEquality().hash(schema));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MappingRuleImplCopyWith<_$MappingRuleImpl> get copyWith =>
      __$$MappingRuleImplCopyWithImpl<_$MappingRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MappingRuleImplToJson(
      this,
    );
  }
}

abstract class _MappingRule implements MappingRule {
  const factory _MappingRule(
      {required final String key,
      @JsonKey(name: 'type') required final MappingType mappingType,
      final String? source,
      final String? transform,
      final String? template,
      final dynamic value,
      final List<MappingRule>? subMappings,
      final MergeStrategy mergeStrategy,
      final String? condition,
      final List<String>? dependsOn,
      final String? comment,
      final String? lang,
      final String? expectedType,
      final dynamic schema}) = _$MappingRuleImpl;

  factory _MappingRule.fromJson(Map<String, dynamic> json) =
      _$MappingRuleImpl.fromJson;

  @override
  String get key;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'type')
  MappingType get mappingType;
  @override
  String? get source;
  @override
  String? get transform;
  @override
  String? get template;
  @override
  dynamic get value;
  @override
  List<MappingRule>? get subMappings;
  @override
  MergeStrategy get mergeStrategy;
  @override
  String? get condition;
  @override
  List<String>? get dependsOn;
  @override
  String? get comment;
  @override
  String? get lang;
  @override
  String? get expectedType;
  @override
  dynamic get schema;
  @override
  @JsonKey(ignore: true)
  _$$MappingRuleImplCopyWith<_$MappingRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
