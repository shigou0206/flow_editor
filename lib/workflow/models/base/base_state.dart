import 'retry_policy.dart';
import 'catch_policy.dart';

abstract class BaseState {
  String get type;
  String? get comment;
  String? get next;
  bool? get end;
  List<RetryPolicy>? get retry;
  List<CatchPolicy>? get catchPolicy;

  Map<String, dynamic> toJson();
}
