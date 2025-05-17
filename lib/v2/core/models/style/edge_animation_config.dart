import 'package:equatable/equatable.dart';

// ===================== 动画子结构：EdgeAnimationConfig ===================== //
class EdgeAnimationConfig extends Equatable {
  final bool animate; // 是否开启通用动画
  final String? animationType; // "flowPulse", "dashBlink", ...
  final double? animationSpeed;
  final double? animationPhase;
  final String? animationColorHex;

  // 针对"dash流动"的三个字段
  final bool animateDash;
  final double? dashFlowPhase;
  final double? dashFlowSpeed;

  const EdgeAnimationConfig({
    this.animate = false,
    this.animationType,
    this.animationSpeed,
    this.animationPhase,
    this.animationColorHex,
    this.animateDash = false,
    this.dashFlowPhase,
    this.dashFlowSpeed,
  });

  EdgeAnimationConfig copyWith({
    bool? animate,
    String? animationType,
    double? animationSpeed,
    double? animationPhase,
    String? animationColorHex,
    bool? animateDash,
    double? dashFlowPhase,
    double? dashFlowSpeed,
  }) {
    return EdgeAnimationConfig(
      animate: animate ?? this.animate,
      animationType: animationType ?? this.animationType,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      animationPhase: animationPhase ?? this.animationPhase,
      animationColorHex: animationColorHex ?? this.animationColorHex,
      animateDash: animateDash ?? this.animateDash,
      dashFlowPhase: dashFlowPhase ?? this.dashFlowPhase,
      dashFlowSpeed: dashFlowSpeed ?? this.dashFlowSpeed,
    );
  }

  // 序列化
  Map<String, dynamic> toJson() {
    return {
      'animate': animate,
      'animationType': animationType,
      'animationSpeed': animationSpeed,
      'animationPhase': animationPhase,
      'animationColorHex': animationColorHex,
      'animateDash': animateDash,
      'dashFlowPhase': dashFlowPhase,
      'dashFlowSpeed': dashFlowSpeed,
    };
  }

  // 反序列化
  factory EdgeAnimationConfig.fromJson(Map<String, dynamic> json) {
    return EdgeAnimationConfig(
      animate: _asBool(json['animate'], false),
      animationType: json['animationType'] as String?,
      animationSpeed: _asDouble(json['animationSpeed']),
      animationPhase: _asDouble(json['animationPhase']),
      animationColorHex: json['animationColorHex'] as String?,
      animateDash: _asBool(json['animateDash'], false),
      dashFlowPhase: _asDouble(json['dashFlowPhase']),
      dashFlowSpeed: _asDouble(json['dashFlowSpeed']),
    );
  }

  // === 内部解析函数 ===
  static bool _asBool(dynamic val, bool fallback) {
    if (val is bool) return val;
    return fallback;
  }

  static double? _asDouble(dynamic val) {
    if (val is num) return val.toDouble();
    return null;
  }

  @override
  List<Object?> get props => [
        animate,
        animationType,
        animationSpeed,
        animationPhase,
        animationColorHex,
        animateDash,
        dashFlowPhase,
        dashFlowSpeed
      ];
}
