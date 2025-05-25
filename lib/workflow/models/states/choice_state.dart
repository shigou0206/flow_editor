import 'package:freezed_annotation/freezed_annotation.dart';
import '../base/base_state.dart';
import '../base/retry_policy.dart';
import '../base/catch_policy.dart';
import '../logic/choice_rule.dart';

part 'choice_state.freezed.dart';
part 'choice_state.g.dart';

@freezed
class ChoiceState with _$ChoiceState implements BaseState {
  const ChoiceState._(); // 私有构造函数

  const factory ChoiceState({
    @Default('Choice') String type,
    String? comment,
    required List<ChoiceRule> choices,
    String? defaultNext,
    @Default(null) String? next, // 明确声明为null
    @Default(null) bool? end, // 明确声明为null
    @Default(null) List<RetryPolicy>? retry, // 明确声明为null
    @Default(null) List<CatchPolicy>? catchPolicy, // 明确声明为null
  }) = _ChoiceState;

  factory ChoiceState.fromJson(Map<String, dynamic> json) =>
      _$ChoiceStateFromJson(json);
}
