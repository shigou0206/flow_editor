import 'package:flow_editor/v2/core/models/enums.dart';

class AnchorModel {
  final String id;
  final double width;
  final double height;
  final Position position;
  final double ratio;

  final AnchorDirection direction;
  final int? maxConnections;
  final List<String>? acceptedEdgeTypes;
  final AnchorShape shape;
  final ArrowDirection arrowDirection;

  final bool locked;
  final int version;
  final String? lockedByUser;
  final String? plusButtonColorHex;
  final double? plusButtonSize;
  final String? iconName;
  final Map<String, dynamic> data;

  // 新增字段：确定放置位置(inside/border/outside)、距离、角度
  final AnchorPlacement placement;
  final double offsetDistance; // 节点边缘的偏移量
  final double angle; // 相对边缘法线的旋转角度

  final String nodeId;

  AnchorModel({
    required this.id,
    required this.width,
    required this.height,
    required this.position,
    double ratio = 0.5,
    this.direction = AnchorDirection.inout,
    this.maxConnections,
    this.acceptedEdgeTypes,
    this.shape = AnchorShape.circle,
    this.arrowDirection = ArrowDirection.none,
    this.locked = false,
    this.version = 1,
    this.lockedByUser,
    this.plusButtonColorHex,
    this.plusButtonSize,
    this.iconName,
    this.data = const {},
    // 新增
    this.placement = AnchorPlacement.border,
    double offsetDistance = 0.0,
    this.angle = 0.0,
    required this.nodeId,
  })  : ratio = (ratio < 0.0
            ? 0.0
            : ratio > 1.0
                ? 1.0
                : ratio),
        offsetDistance = offsetDistance < 0.0 ? 0.0 : offsetDistance;

  // copyWith
  AnchorModel copyWith({
    String? id,
    double? width,
    double? height,
    Position? position,
    double? ratio,
    AnchorDirection? direction,
    int? maxConnections,
    List<String>? acceptedEdgeTypes,
    AnchorShape? shape,
    ArrowDirection? arrowDirection,
    bool? locked,
    int? version,
    String? lockedByUser,
    String? plusButtonColorHex,
    double? plusButtonSize,
    String? iconName,
    Map<String, dynamic>? data,
    AnchorPlacement? placement,
    double? offsetDistance,
    double? angle,
    String? nodeId,
  }) {
    return AnchorModel(
      id: id ?? this.id,
      width: width ?? this.width,
      height: height ?? this.height,
      position: position ?? this.position,
      ratio: ratio ?? this.ratio,
      direction: direction ?? this.direction,
      maxConnections: maxConnections ?? this.maxConnections,
      acceptedEdgeTypes: acceptedEdgeTypes ?? this.acceptedEdgeTypes,
      shape: shape ?? this.shape,
      arrowDirection: arrowDirection ?? this.arrowDirection,
      locked: locked ?? this.locked,
      version: version ?? this.version,
      lockedByUser: lockedByUser ?? this.lockedByUser,
      plusButtonColorHex: plusButtonColorHex ?? this.plusButtonColorHex,
      plusButtonSize: plusButtonSize ?? this.plusButtonSize,
      iconName: iconName ?? this.iconName,
      data: data ?? this.data,
      placement: placement ?? this.placement,
      offsetDistance: offsetDistance ?? this.offsetDistance,
      angle: angle ?? this.angle,
      nodeId: nodeId ?? this.nodeId,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': position.toString().split('.').last,
      'ratio': ratio,
      'direction': direction.toString().split('.').last,
      'maxConnections': maxConnections,
      'acceptedEdgeTypes': acceptedEdgeTypes,
      'shape': shape.toString().split('.').last,
      'arrowDirection': arrowDirection.toString().split('.').last,
      'locked': locked,
      'version': version,
      'lockedByUser': lockedByUser,
      'plusButtonColorHex': plusButtonColorHex,
      'plusButtonSize': plusButtonSize,
      'iconName': iconName,
      'data': data,
      // 新增
      'placement': placement.toString().split('.').last,
      'offsetDistance': offsetDistance,
      'angle': angle,
      'nodeId': nodeId,
    };
  }

  // fromJson
  factory AnchorModel.fromJson(Map<String, dynamic> json) {
    return AnchorModel(
      id: json['id']?.toString() ?? '',
      width: json['width'] is num ? (json['width'] as num).toDouble() : 12.0,
      height: json['height'] is num ? (json['height'] as num).toDouble() : 12.0,
      position: _parsePosition(json['position']),
      ratio: _parseRatio(json['ratio']),
      direction: _parseAnchorDirection(json['direction']),
      maxConnections: json['maxConnections'] is num
          ? (json['maxConnections'] as num).toInt()
          : null,
      acceptedEdgeTypes: json['acceptedEdgeTypes'] is List
          ? (json['acceptedEdgeTypes'] as List)
              .map((e) => e.toString())
              .toList()
          : null,
      shape: _parseAnchorShape(json['shape']),
      arrowDirection: _parseArrowDirection(json['arrowDirection']),
      locked: json['locked'] is bool ? json['locked'] : false,
      version: json['version'] is num ? (json['version'] as num).toInt() : 1,
      lockedByUser: json['lockedByUser']?.toString(),
      plusButtonColorHex: json['plusButtonColorHex']?.toString(),
      plusButtonSize: json['plusButtonSize'] is num
          ? (json['plusButtonSize'] as num).toDouble()
          : null,
      iconName: json['iconName']?.toString(),
      data: _mapOrEmpty(json['data']),
      placement: _parseAnchorPlacement(json['placement']),
      offsetDistance: json['offsetDistance'] is num
          ? (json['offsetDistance'] as num).toDouble()
          : 0.0,
      angle: json['angle'] is num ? (json['angle'] as num).toDouble() : 0.0,
      nodeId: json['nodeId']?.toString() ?? '',
    );
  }

  // =========== 内部解析函数 ===========
  static Position _parsePosition(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'right':
          return Position.right;
        case 'top':
          return Position.top;
        case 'bottom':
          return Position.bottom;
        default:
          return Position.left;
      }
    }
    return Position.left;
  }

  static double _parseRatio(dynamic val) {
    if (val is num) {
      final parsed = val.toDouble();
      if (parsed < 0.0) return 0.0;
      if (parsed > 1.0) return 1.0;
      return parsed;
    }
    return 0.5;
  }

  static AnchorDirection _parseAnchorDirection(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'inOnly':
          return AnchorDirection.inOnly;
        case 'outOnly':
          return AnchorDirection.outOnly;
        case 'inout':
          return AnchorDirection.inout;
      }
    }
    return AnchorDirection.inout;
  }

  static AnchorShape _parseAnchorShape(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'diamond':
          return AnchorShape.diamond;
        case 'square':
          return AnchorShape.square;
        case 'custom':
          return AnchorShape.custom;
        default:
          return AnchorShape.circle;
      }
    }
    return AnchorShape.circle;
  }

  static ArrowDirection _parseArrowDirection(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'inward':
          return ArrowDirection.inward;
        case 'outward':
          return ArrowDirection.outward;
        default:
          return ArrowDirection.none;
      }
    }
    return ArrowDirection.none;
  }

  static Map<String, dynamic> _mapOrEmpty(dynamic obj) {
    if (obj is Map<String, dynamic>) {
      return obj;
    }
    return {};
  }

  // 新增解析AnchorPlacement
  static AnchorPlacement _parseAnchorPlacement(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'inside':
          return AnchorPlacement.inside;
        case 'outside':
          return AnchorPlacement.outside;
        default:
          return AnchorPlacement.border;
      }
    }
    return AnchorPlacement.border;
  }
}
