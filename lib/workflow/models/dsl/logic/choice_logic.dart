import 'package:freezed_annotation/freezed_annotation.dart';

part 'choice_logic.freezed.dart';
part 'choice_logic.g.dart';

// List<ChoiceLogic>序列化函数
List<Map<String, dynamic>>? _choiceLogicListToJson(List<ChoiceLogic>? list) =>
    list?.map((e) => e.toJson()).toList();

List<ChoiceLogic>? _choiceLogicListFromJson(List<dynamic>? json) =>
    json?.map((e) => ChoiceLogic.fromJson(e as Map<String, dynamic>)).toList();

// 单个ChoiceLogic序列化函数（新加的，关键！）
Map<String, dynamic>? _choiceLogicToJson(ChoiceLogic? logic) => logic?.toJson();

ChoiceLogic? _choiceLogicFromJson(Map<String, dynamic>? json) =>
    json == null ? null : ChoiceLogic.fromJson(json);

@freezed
class ChoiceLogic with _$ChoiceLogic {
  const ChoiceLogic._();

  const factory ChoiceLogic({
    // ignore: invalid_annotation_target
    @JsonKey(
        name: 'And',
        toJson: _choiceLogicListToJson,
        fromJson: _choiceLogicListFromJson)
    List<ChoiceLogic>? and,

    // ignore: invalid_annotation_target
    @JsonKey(
        name: 'Or',
        toJson: _choiceLogicListToJson,
        fromJson: _choiceLogicListFromJson)
    List<ChoiceLogic>? or,

    // ignore: invalid_annotation_target
    @JsonKey(
        name: 'Not',
        toJson: _choiceLogicToJson,
        fromJson: _choiceLogicFromJson) // <-- 修复点
    ChoiceLogic? not,
    String? variable,
    String? operator,
    dynamic value,
  }) = _ChoiceLogic;

  factory ChoiceLogic.fromJson(Map<String, dynamic> json) =>
      _$ChoiceLogicFromJson(json);
}
