import 'package:freezed_annotation/freezed_annotation.dart';
import 'mapping_type.dart';
import 'merge_strategy.dart';

part 'mapping_rule.freezed.dart';
part 'mapping_rule.g.dart';

@freezed
class MappingRule with _$MappingRule {
  const factory MappingRule({
    required String key,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'type') required MappingType mappingType,
    String? source,
    String? transform,
    String? template,
    dynamic value,
    List<MappingRule>? subMappings,
    @Default(MergeStrategy.overwrite) MergeStrategy mergeStrategy,
    String? condition,
    List<String>? dependsOn,
    String? comment,
    String? lang,
    String? expectedType,
    dynamic schema,
  }) = _MappingRule;

  factory MappingRule.fromJson(Map<String, dynamic> json) =>
      _$MappingRuleFromJson(json);
}
