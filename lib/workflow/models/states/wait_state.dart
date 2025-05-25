import 'package:flow_editor/workflow/models/base/catch_policy.dart';
import 'package:flow_editor/workflow/models/base/retry_policy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../base/base_state.dart';

part 'wait_state.freezed.dart';
part 'wait_state.g.dart';

@freezed
class WaitState with _$WaitState implements BaseState {
  const WaitState._(); // 必须的私有构造函数，支持自定义getter或接口实现

  const factory WaitState({
    @Default('Wait') String type,
    String? comment,
    String? next,
    bool? end,
    int? seconds,
    String? timestamp,
    List<RetryPolicy>? retry, // ✅ 新添加，满足BaseState接口
    List<CatchPolicy>? catchPolicy, // ✅ 新添加，满足BaseState接口
  }) = _WaitState;

  factory WaitState.fromJson(Map<String, dynamic> json) =>
      _$WaitStateFromJson(json);
}
