import 'package:freezed_annotation/freezed_annotation.dart';

part 'hit_test_tolerance.freezed.dart';
part 'hit_test_tolerance.g.dart';

@freezed
class HitTestTolerance with _$HitTestTolerance {
  const factory HitTestTolerance({
    /// 命中 Anchor 的半径阈值（默认 10 像素）
    @Default(10.0) double anchor,

    /// 命中 Edge 的路径距离容差（默认 6 像素）
    @Default(6.0) double edge,

    /// 命中 Waypoint（边拐点）的容差（默认 8 像素）
    @Default(8.0) double waypoint,

    /// 命中 Resize Handle 的容差（默认 10 像素）
    @Default(10.0) double resizeHandle,
  }) = _HitTestTolerance;

  factory HitTestTolerance.fromJson(Map<String, dynamic> json) =>
      _$HitTestToleranceFromJson(json);
}
