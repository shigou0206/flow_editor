import 'edge_enums.dart';
import 'package:equatable/equatable.dart';

// ===================== 样式子结构：EdgeLineStyle ===================== //
class EdgeLineStyle extends Equatable {
  final String colorHex; // "#RRGGBB" / "#AARRGGBB"
  final double strokeWidth; // 线宽
  final List<double> dashPattern; // 虚线模式 [5,2] => 5px on,2px off
  final EdgeLineCap lineCap; // 线端点样式
  final EdgeLineJoin lineJoin; // 拐角样式
  final bool useBezier; // 是否使用贝塞尔曲线
  final ArrowType arrowStart; // 起点箭头类型
  final ArrowType arrowEnd; // 终点箭头类型
  final double arrowSize; // 箭头大小
  final double arrowAngleDeg; // 箭头夹角(角度)

  const EdgeLineStyle({
    this.colorHex = '#000000',
    this.strokeWidth = 1.0,
    this.dashPattern = const [], // 默认空数组
    this.lineCap = EdgeLineCap.butt,
    this.lineJoin = EdgeLineJoin.miter,
    this.useBezier = false,
    this.arrowStart = ArrowType.none,
    this.arrowEnd = ArrowType.none,
    this.arrowSize = 1.0,
    this.arrowAngleDeg = 30.0,
  });

  // copyWith - 用于不可变更新
  EdgeLineStyle copyWith({
    String? colorHex,
    double? strokeWidth,
    List<double>? dashPattern,
    EdgeLineCap? lineCap,
    EdgeLineJoin? lineJoin,
    bool? useBezier,
    ArrowType? arrowStart,
    ArrowType? arrowEnd,
    double? arrowSize,
    double? arrowAngleDeg,
  }) {
    return EdgeLineStyle(
      colorHex: colorHex ?? this.colorHex,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      dashPattern: dashPattern ?? List.from(this.dashPattern),
      lineCap: lineCap ?? this.lineCap,
      lineJoin: lineJoin ?? this.lineJoin,
      useBezier: useBezier ?? this.useBezier,
      arrowStart: arrowStart ?? this.arrowStart,
      arrowEnd: arrowEnd ?? this.arrowEnd,
      arrowSize: arrowSize ?? this.arrowSize,
      arrowAngleDeg: arrowAngleDeg ?? this.arrowAngleDeg,
    );
  }

  // 序列化
  Map<String, dynamic> toJson() {
    return {
      'colorHex': colorHex,
      'strokeWidth': strokeWidth,
      'dashPattern': dashPattern,
      'lineCap': lineCap.toString().split('.').last,
      'lineJoin': lineJoin.toString().split('.').last,
      'useBezier': useBezier,
      'arrowStart': arrowStart.toString().split('.').last,
      'arrowEnd': arrowEnd.toString().split('.').last,
      'arrowSize': arrowSize,
      'arrowAngleDeg': arrowAngleDeg,
    };
  }

  // 反序列化
  factory EdgeLineStyle.fromJson(Map<String, dynamic> json) {
    return EdgeLineStyle(
      colorHex: json['colorHex'] as String? ?? '#000000',
      strokeWidth: (json['strokeWidth'] is num)
          ? (json['strokeWidth'] as num).toDouble()
          : 1.0,
      dashPattern: _parseDoubleList(json['dashPattern']),
      lineCap: _parseLineCap(json['lineCap']),
      lineJoin: _parseLineJoin(json['lineJoin']),
      useBezier: json['useBezier'] as bool? ?? false,
      arrowStart: _parseArrowType(json['arrowStart']),
      arrowEnd: _parseArrowType(json['arrowEnd']),
      arrowSize: (json['arrowSize'] is num)
          ? (json['arrowSize'] as num).toDouble()
          : 10.0,
      arrowAngleDeg: (json['arrowAngleDeg'] is num)
          ? (json['arrowAngleDeg'] as num).toDouble()
          : 30.0,
    );
  }

  // ============ 内部解析函数 ============

  static EdgeLineCap _parseLineCap(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'round':
          return EdgeLineCap.round;
        case 'square':
          return EdgeLineCap.square;
        default:
          return EdgeLineCap.butt;
      }
    }
    return EdgeLineCap.butt;
  }

  static EdgeLineJoin _parseLineJoin(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'round':
          return EdgeLineJoin.round;
        case 'bevel':
          return EdgeLineJoin.bevel;
        default:
          return EdgeLineJoin.miter;
      }
    }
    return EdgeLineJoin.miter;
  }

  static ArrowType _parseArrowType(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'triangle':
          return ArrowType.triangle;
        case 'diamond':
          return ArrowType.diamond;
        case 'arrow':
          return ArrowType.arrow;
        default:
          return ArrowType.none;
      }
    }
    return ArrowType.none;
  }

  static List<double> _parseDoubleList(dynamic val) {
    if (val is List) {
      return val.map((e) => (e as num).toDouble()).toList();
    }
    return [];
  }

  @override
  List<Object?> get props => [
        colorHex,
        strokeWidth,
        dashPattern,
        lineCap,
        lineJoin,
        useBezier,
        arrowStart,
        arrowEnd,
        arrowSize,
        arrowAngleDeg,
      ];
}
