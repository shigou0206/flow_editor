import 'package:freezed_annotation/freezed_annotation.dart';

part 'edge_animation_config.freezed.dart';
part 'edge_animation_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true, createFactory: false)
class EdgeAnimationConfig with _$EdgeAnimationConfig {
  const EdgeAnimationConfig._();

  const factory EdgeAnimationConfig({
    @Default(false) bool animate,
    String? animationType,
    double? animationSpeed,
    double? animationPhase,
    String? animationColorHex,
    @Default(false) bool animateDash,
    double? dashFlowPhase,
    double? dashFlowSpeed,
  }) = _EdgeAnimationConfig;

  factory EdgeAnimationConfig.fromJson(Map<String, dynamic> json) =>
      _$EdgeAnimationConfigFromJson(json);
}
