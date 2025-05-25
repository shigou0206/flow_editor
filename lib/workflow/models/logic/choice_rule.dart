import 'package:freezed_annotation/freezed_annotation.dart';
import 'choice_logic.dart';

part 'choice_rule.freezed.dart';
part 'choice_rule.g.dart';

@freezed
class ChoiceRule with _$ChoiceRule {
  const factory ChoiceRule({
    required ChoiceLogic condition,
    required String next,
  }) = _ChoiceRule;

  factory ChoiceRule.fromJson(Map<String, dynamic> json) =>
      _$ChoiceRuleFromJson(json);
}
