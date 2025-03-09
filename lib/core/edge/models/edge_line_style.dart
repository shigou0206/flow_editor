import 'package:equatable/equatable.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';

/// EdgeLineStyle: 线条样式配置
///
/// - edgeMode: 指定使用哪种连接模式 (line / orthogonal3 / orthogonal5 / bezier / hvBezier ... )
/// - colorHex: 线条颜色
/// - strokeWidth: 线宽
/// - dashPattern: [5,2] => 5px on,2px off
/// - lineCap, lineJoin: 拐角样式
/// - arrowStart,arrowEnd,arrowSize,arrowAngleDeg: 箭头样式
class EdgeLineStyle extends Equatable {
  final EdgeMode edgeMode; // 现在用枚举 而非 useBezier
  final String colorHex;
  final double strokeWidth;
  final List<double> dashPattern;
  final EdgeLineCap lineCap;
  final EdgeLineJoin lineJoin;
  final ArrowType arrowStart;
  final ArrowType arrowEnd;
  final double arrowSize;
  final double arrowAngleDeg;

  const EdgeLineStyle({
    this.edgeMode = EdgeMode.hvBezier, // 默认直线 or 你喜欢 => EdgeMode.bezier
    this.colorHex = '#000000',
    this.strokeWidth = 1.0,
    this.dashPattern = const [],
    this.lineCap = EdgeLineCap.butt,
    this.lineJoin = EdgeLineJoin.miter,
    this.arrowStart = ArrowType.none,
    this.arrowEnd = ArrowType.none,
    this.arrowSize = 1.0,
    this.arrowAngleDeg = 30.0,
  });

  // copyWith
  EdgeLineStyle copyWith({
    EdgeMode? edgeMode,
    String? colorHex,
    double? strokeWidth,
    List<double>? dashPattern,
    EdgeLineCap? lineCap,
    EdgeLineJoin? lineJoin,
    ArrowType? arrowStart,
    ArrowType? arrowEnd,
    double? arrowSize,
    double? arrowAngleDeg,
  }) {
    return EdgeLineStyle(
      edgeMode: edgeMode ?? this.edgeMode,
      colorHex: colorHex ?? this.colorHex,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      dashPattern: dashPattern ?? List.from(this.dashPattern),
      lineCap: lineCap ?? this.lineCap,
      lineJoin: lineJoin ?? this.lineJoin,
      arrowStart: arrowStart ?? this.arrowStart,
      arrowEnd: arrowEnd ?? this.arrowEnd,
      arrowSize: arrowSize ?? this.arrowSize,
      arrowAngleDeg: arrowAngleDeg ?? this.arrowAngleDeg,
    );
  }

  // ============ 序列化 ============
  Map<String, dynamic> toJson() {
    return {
      'edgeMode': edgeMode.toString().split('.').last,
      'colorHex': colorHex,
      'strokeWidth': strokeWidth,
      'dashPattern': dashPattern,
      'lineCap': lineCap.toString().split('.').last,
      'lineJoin': lineJoin.toString().split('.').last,
      'arrowStart': arrowStart.toString().split('.').last,
      'arrowEnd': arrowEnd.toString().split('.').last,
      'arrowSize': arrowSize,
      'arrowAngleDeg': arrowAngleDeg,
    };
  }

  // ============ 反序列化 ============
  factory EdgeLineStyle.fromJson(Map<String, dynamic> json) {
    return EdgeLineStyle(
      edgeMode: _parseEdgeMode(json['edgeMode']),
      colorHex: json['colorHex'] as String? ?? '#000000',
      strokeWidth: (json['strokeWidth'] is num)
          ? (json['strokeWidth'] as num).toDouble()
          : 1.0,
      dashPattern: _parseDoubleList(json['dashPattern']),
      lineCap: _parseLineCap(json['lineCap']),
      lineJoin: _parseLineJoin(json['lineJoin']),
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

  static EdgeMode _parseEdgeMode(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'orthogonal3':
          return EdgeMode.orthogonal3;
        case 'orthogonal5':
          return EdgeMode.orthogonal5;
        case 'bezier':
          return EdgeMode.bezier;
        case 'hvBezier':
          return EdgeMode.hvBezier;
        case 'line':
        default:
          return EdgeMode.line;
      }
    }
    return EdgeMode.line;
  }

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
        edgeMode,
        colorHex,
        strokeWidth,
        dashPattern,
        lineCap,
        lineJoin,
        arrowStart,
        arrowEnd,
        arrowSize,
        arrowAngleDeg,
      ];
}
