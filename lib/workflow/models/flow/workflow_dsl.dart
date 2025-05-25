import 'package:freezed_annotation/freezed_annotation.dart';

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
    required Map<String, dynamic> states,
  }) = _WorkflowDSL;

  factory WorkflowDSL.fromJson(Map<String, dynamic> json) =>
      _$WorkflowDSLFromJson(json);
}
