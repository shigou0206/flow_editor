import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/dsl/base/retry_policy.dart';
import 'package:flow_editor/workflow/models/dsl/base/catch_policy.dart';
import 'package:flow_editor/workflow/models/dsl/logic/choice_rule.dart';
import 'package:flow_editor/workflow/models/dsl/mapping/mapping_dsl.dart';

part 'choice_state.freezed.dart';
part 'choice_state.g.dart';

@freezed
class ChoiceState with _$ChoiceState {
  const ChoiceState._(); // 私有构造函数

  const factory ChoiceState({
    required List<ChoiceRule> choices,
    String? defaultNext,
    @Default(null) String? comment,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) MappingDSL? inputMapping,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) MappingDSL? outputMapping,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) List<RetryPolicy>? retry,

    // ignore: invalid_annotation_target
    @JsonKey(name: 'catch', defaultValue: null) List<CatchPolicy>? catchPolicy,
    @Default(null) String? next,
    @Default(null) bool? end,
  }) = _ChoiceState;

  factory ChoiceState.fromJson(Map<String, dynamic> json) =>
      _$ChoiceStateFromJson(json);
}
