import 'package:flow_editor/core/edge/models/edge_animation_config.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';

class EdgeModel {
  // ===== 基本连接信息 =====
  final String id;
  final String sourceNodeId;
  final String? sourceAnchorId;
  final String? targetNodeId;
  final String? targetAnchorId;
  final bool isConnected;

  // ===== 分类 / 状态 / 协作 =====
  final String edgeType; // "flow", "dependency", ...
  final String? status; // "none", "running", "error"...
  final bool locked;
  final String? lockedByUser;
  final int version;
  final int zIndex;

  // ===== 折线/waypoints =====
  final List<List<double>>? waypoints;

  // ===== 样式 & 动画 =====
  final EdgeLineStyle lineStyle;
  final EdgeAnimationConfig animConfig;

  // ===== label / tag =====
  final String? label;
  final Map<String, dynamic>? labelStyle;

  // ===== 额外数据 =====
  final Map<String, dynamic> data;

  const EdgeModel({
    required this.id,
    required this.sourceNodeId,
    required this.sourceAnchorId,
    this.targetNodeId,
    this.targetAnchorId,
    this.isConnected = false,
    this.edgeType = "default",
    this.status,
    this.locked = false,
    this.lockedByUser,
    this.version = 1,
    this.zIndex = 0,
    this.waypoints,
    this.lineStyle = const EdgeLineStyle(),
    this.animConfig = const EdgeAnimationConfig(),
    this.label,
    this.labelStyle,
    this.data = const {},
  });

  // copyWith
  EdgeModel copyWith({
    String? id,
    String? sourceNodeId,
    String? sourceAnchorId,
    String? targetNodeId,
    String? targetAnchorId,
    bool? isConnected,
    String? edgeType,
    String? status,
    bool? locked,
    String? lockedByUser,
    int? version,
    int? zIndex,
    List<List<double>>? waypoints,
    EdgeLineStyle? lineStyle,
    EdgeAnimationConfig? animConfig,
    String? label,
    Map<String, dynamic>? labelStyle,
    Map<String, dynamic>? data,
  }) {
    return EdgeModel(
      id: id ?? this.id,
      sourceNodeId: sourceNodeId ?? this.sourceNodeId,
      sourceAnchorId: sourceAnchorId ?? this.sourceAnchorId,
      targetNodeId: targetNodeId ?? this.targetNodeId,
      targetAnchorId: targetAnchorId ?? this.targetAnchorId,
      isConnected: isConnected ?? this.isConnected,
      edgeType: edgeType ?? this.edgeType,
      status: status ?? this.status,
      locked: locked ?? this.locked,
      lockedByUser: lockedByUser ?? this.lockedByUser,
      version: version ?? this.version,
      zIndex: zIndex ?? this.zIndex,
      waypoints: waypoints ?? this.waypoints,
      lineStyle: lineStyle ?? this.lineStyle,
      animConfig: animConfig ?? this.animConfig,
      label: label ?? this.label,
      labelStyle: labelStyle ?? this.labelStyle,
      data: data ?? this.data,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sourceNodeId': sourceNodeId,
      'sourceAnchorId': sourceAnchorId,
      'targetNodeId': targetNodeId,
      'targetAnchorId': targetAnchorId,
      'isConnected': isConnected,
      'edgeType': edgeType,
      'status': status,
      'locked': locked,
      'lockedByUser': lockedByUser,
      'version': version,
      'zIndex': zIndex,
      'waypoints': waypoints,
      'lineStyle': lineStyle.toJson(),
      'animConfig': animConfig.toJson(),
      'label': label,
      'labelStyle': labelStyle,
      'data': data,
    };
  }

  // fromJson
  factory EdgeModel.fromJson(Map<String, dynamic> json) {
    return EdgeModel(
      id: json['id'] as String,
      sourceNodeId: json['sourceNodeId'] as String,
      sourceAnchorId: json['sourceAnchorId'] as String,
      targetNodeId: json['targetNodeId'] as String?,
      targetAnchorId: json['targetAnchorId'] as String?,
      isConnected: _asBool(json['isConnected'], false),
      edgeType: json['edgeType'] as String? ?? "default",
      status: json['status'] as String?,
      locked: _asBool(json['locked'], false),
      lockedByUser: json['lockedByUser'] as String?,
      version: _asInt(json['version'], 1),
      zIndex: _asInt(json['zIndex'], 0),
      waypoints: _parseWaypoints(json['waypoints']),
      lineStyle: (json['lineStyle'] is Map<String, dynamic>)
          ? EdgeLineStyle.fromJson(json['lineStyle'])
          : const EdgeLineStyle(),
      animConfig: (json['animConfig'] is Map<String, dynamic>)
          ? EdgeAnimationConfig.fromJson(json['animConfig'])
          : const EdgeAnimationConfig(),
      label: json['label'] as String?,
      labelStyle: _mapOrNull(json['labelStyle']),
      data: _mapOrEmpty(json['data']),
    );
  }

  // =========== 内部解析函数 ===========

  static bool _asBool(dynamic val, bool fallback) {
    if (val is bool) return val;
    return fallback;
  }

  static int _asInt(dynamic val, int fallback) {
    if (val is num) return val.toInt();
    return fallback;
  }

  // static double? _asDouble(dynamic val) {
  //   if (val is num) return val.toDouble();
  //   return null;
  // }

  static List<List<double>>? _parseWaypoints(dynamic val) {
    if (val is List) {
      return val.map((point) {
        if (point is List && point.length == 2) {
          final x = (point[0] as num).toDouble();
          final y = (point[1] as num).toDouble();
          return [x, y];
        }
        return <double>[]; // or skip
      }).toList();
    }
    return null;
  }

  static Map<String, dynamic>? _mapOrNull(dynamic obj) {
    if (obj is Map<String, dynamic>) return obj;
    return null;
  }

  static Map<String, dynamic> _mapOrEmpty(dynamic obj) {
    if (obj is Map<String, dynamic>) {
      return obj;
    }
    return {};
  }
}
