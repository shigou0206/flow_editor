import 'package:flow_editor/workflow/models/logic/choice_logic.dart';

void main() {
  final logic = ChoiceLogic(
    and: [
      ChoiceLogic(variable: 'score', operator: 'GreaterThan', value: 90),
    ],
    not: ChoiceLogic(variable: 'status', operator: 'Equals', value: 'blocked'),
  );

  final json = logic.toJson();
  print('序列化后的JSON:\n$json');

  final logicFromJson = ChoiceLogic.fromJson(json);
  print('反序列化的对象:\n$logicFromJson');
}
