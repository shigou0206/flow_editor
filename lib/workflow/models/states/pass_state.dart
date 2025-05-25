import 'package:flow_editor/workflow/models/base/catch_policy.dart';
import 'package:flow_editor/workflow/models/base/retry_policy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../base/base_state.dart';

part 'pass_state.freezed.dart';
part 'pass_state.g.dart';

@freezed
class PassState with _$PassState implements BaseState {
  const PassState._(); // 私有构造函数必不可少（关键）

  const factory PassState({
    @Default('Pass') String type,
    String? comment,
    String? next,
    bool? end,
    dynamic result,
    String? resultPath,
    List<RetryPolicy>? retry,
    List<CatchPolicy>? catchPolicy,
  }) = _PassState;

  factory PassState.fromJson(Map<String, dynamic> json) =>
      _$PassStateFromJson(json);
}
