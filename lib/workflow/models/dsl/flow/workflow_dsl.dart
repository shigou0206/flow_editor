import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/dsl/flow/workflow_state.dart';
part 'workflow_dsl.freezed.dart';
part 'workflow_dsl.g.dart';

@freezed
class WorkflowDSL with _$WorkflowDSL {
  const factory WorkflowDSL({
    String? comment,
    @Default('1.0.0') String version,
    required String startAt,
    // ignore: invalid_annotation_target
    @JsonKey(includeIfNull: false) Map<String, dynamic>? globalConfig,
    // ignore: invalid_annotation_target
    @JsonKey(includeIfNull: false) Map<String, dynamic>? errorHandling,
    required Map<String, WorkflowState> states,
  }) = _WorkflowDSL;

  factory WorkflowDSL.fromJson(Map<String, dynamic> json) =>
      _$WorkflowDSLFromJson(json);
}
