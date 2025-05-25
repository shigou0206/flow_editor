import 'package:freezed_annotation/freezed_annotation.dart';
import '../base/base_state.dart';
import '../base/retry_policy.dart';
import '../base/catch_policy.dart';

part 'fail_state.freezed.dart';
part 'fail_state.g.dart';

@freezed
class FailState with _$FailState implements BaseState {
  const FailState._(); // 必须的私有构造函数

  const factory FailState({
    @Default('Fail') String type,
    String? comment,
    String? error,
    String? cause,
    @Default(null) String? next, // 明确声明为null
    @Default(true) bool? end, // 明确声明为true
    @Default(null) List<RetryPolicy>? retry, // 明确声明为null
    @Default(null) List<CatchPolicy>? catchPolicy, // 明确声明为null
  }) = _FailState;

  factory FailState.fromJson(Map<String, dynamic> json) =>
      _$FailStateFromJson(json);
}
