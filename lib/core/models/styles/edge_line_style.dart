import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/enums/edge_enums.dart';

part 'edge_line_style.freezed.dart';
part 'edge_line_style.g.dart';

@freezed
class EdgeLineStyle with _$EdgeLineStyle {
  const factory EdgeLineStyle({
    @Default(EdgeMode.hvBezier) EdgeMode edgeMode,
    @Default('#000000') String colorHex,
    @Default(1.0) double strokeWidth,
    @Default([]) List<double> dashPattern,
    @Default(EdgeLineCap.butt) EdgeLineCap lineCap,
    @Default(EdgeLineJoin.miter) EdgeLineJoin lineJoin,
    @Default(ArrowType.none) ArrowType arrowStart,
    @Default(ArrowType.arrow) ArrowType arrowEnd,
    @Default(10.0) double arrowSize,
    @Default(30.0) double arrowAngleDeg,
  }) = _EdgeLineStyle;

  factory EdgeLineStyle.fromJson(Map<String, dynamic> json) =>
      _$EdgeLineStyleFromJson(json);
}
