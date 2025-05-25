import 'package:freezed_annotation/freezed_annotation.dart';

part 'choice_logic.freezed.dart';
part 'choice_logic.g.dart';

@freezed
class ChoiceLogic with _$ChoiceLogic {
  const factory ChoiceLogic({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'And') List<ChoiceLogic>? and,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'Or') List<ChoiceLogic>? or,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'Not') ChoiceLogic? not,
    String? variable,
    String? operator,
    dynamic value,
  }) = _ChoiceLogic;

  factory ChoiceLogic.fromJson(Map<String, dynamic> json) =>
      _$ChoiceLogicFromJson(json);
}
