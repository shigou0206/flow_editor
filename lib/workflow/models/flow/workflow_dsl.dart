import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/flow/workflow_state.dart';
part 'workflow_dsl.freezed.dart';
part 'workflow_dsl.g.dart';

@freezed
class WorkflowDSL with _$WorkflowDSL {
  const factory WorkflowDSL({
    String? comment,
    @Default('1.0.0') String version,
    required String startAt,
    Map<String, dynamic>? globalConfig,
    Map<String, dynamic>? errorHandling,
    required Map<String, WorkflowState> states,
  }) = _WorkflowDSL;

  factory WorkflowDSL.fromJson(Map<String, dynamic> json) =>
      _$WorkflowDSLFromJson(json);
}

extension WorkflowDSLFlatten on WorkflowDSL {
  Map<String, dynamic> toFlatJson() => {
        'startAt': startAt,
        'states': states.map((k, v) => MapEntry(k, v.toFlatJson())),
      };

  static WorkflowDSL fromFlatJson(Map<String, dynamic> json) => WorkflowDSL(
        startAt: json['startAt'],
        states: (json['states'] as Map<String, dynamic>).map(
          (k, v) => MapEntry(k, WorkflowStateFlatten.fromFlatJson(v)),
        ),
      );
}
