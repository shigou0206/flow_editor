import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/base/retry_policy.dart';
import 'package:flow_editor/workflow/models/base/catch_policy.dart';
import '../base/base_state.dart';

part 'succeed_state.freezed.dart';
part 'succeed_state.g.dart';

@freezed
class SucceedState with _$SucceedState implements BaseState {
  const SucceedState._(); // 必要的私有构造函数

  const factory SucceedState({
    @Default('Succeed') String type,
    String? comment,
    @Default(null) String? next, // 明确声明为null
    @Default(true) bool? end, // 明确声明为true
    @Default(null) List<RetryPolicy>? retry, // 明确声明为null
    @Default(null) List<CatchPolicy>? catchPolicy, // 明确声明为null
  }) = _SucceedState;

  factory SucceedState.fromJson(Map<String, dynamic> json) =>
      _$SucceedStateFromJson(json);
}
