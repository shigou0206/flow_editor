import 'package:flutter/material.dart'; // for Rect, Offset
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';
import 'package:flow_editor/core/node/models/base_node_model.dart';
import 'package:flow_editor/core/node/models/styles/node_style.dart';

class NodeModel extends BaseNodeModel {
  final DragMode dragMode;
  final String type; // 业务自定义类型: e.g. "start", "end"...
  final NodeRole role;
  final String title;
  final List<AnchorModel> anchors;

  // ========== 扩展字段 ==========
  final NodeStatus status;
  final String? parentId;
  final int zIndex;
  final bool enabled;
  final bool locked;
  final String? description;
  final NodeStyle? style;

  // ========== 版本/审计信息 ==========
  final int version;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // ========== 动态数据存储 (与业务扩展) ==========
  final Map<String, dynamic> inputs;
  final Map<String, dynamic> outputs;
  final Map<String, dynamic> config;
  final Map<String, dynamic> data;

  NodeModel({
    required super.id,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    this.dragMode = DragMode.full,
    this.type = "",
    this.role = NodeRole.middle,
    required this.title,
    this.anchors = const [],
    this.status = NodeStatus.none,
    this.parentId,
    this.zIndex = 0,
    this.enabled = true,
    this.locked = false,
    this.description,
    this.style,
    this.version = 1,
    this.createdAt,
    this.updatedAt,
    this.inputs = const {},
    this.outputs = const {},
    this.config = const {},
    this.data = const {},
  });

  // 逻辑坐标Rect, 便于渲染或碰撞检测
  @override
  Rect get rect => Rect.fromLTWH(x, y, width, height);

  AnchorPadding get anchorPadding =>
      computeAnchorPadding(anchors, Size(width, height));

  double get totalWidth => width + anchorPadding.left + anchorPadding.right;
  double get totalHeight => height + anchorPadding.top + anchorPadding.bottom;

  /// 不可变更新: 返回新的 NodeModel 实例
  @override
  NodeModel copyWith({
    double? x,
    double? y,
    double? width,
    double? height,
    DragMode? dragMode,
    String? type,
    NodeRole? role,
    String? title,
    List<AnchorModel>? anchors,
    AnchorPadding? anchorPadding,
    NodeStatus? status,
    String? parentId,
    int? zIndex,
    bool? enabled,
    bool? locked,
    String? description,
    NodeStyle? style,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? inputs,
    Map<String, dynamic>? outputs,
    Map<String, dynamic>? config,
    Map<String, dynamic>? data,
  }) {
    return NodeModel(
      id: id, // id保持不变
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      dragMode: dragMode ?? this.dragMode,
      type: type ?? this.type,
      role: role ?? this.role,
      title: title ?? this.title,
      anchors: anchors ?? this.anchors,
      status: status ?? this.status,
      parentId: parentId ?? this.parentId,
      zIndex: zIndex ?? this.zIndex,
      enabled: enabled ?? this.enabled,
      locked: locked ?? this.locked,
      description: description ?? this.description,
      style: style ?? this.style,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      inputs: inputs ?? this.inputs,
      outputs: outputs ?? this.outputs,
      config: config ?? this.config,
      data: data ?? this.data,
    );
  }

  /// toJson: 序列化为Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'dragMode': dragMode.toString(), // e.g. "DragMode.full"
      'type': type,
      'role': role.toString(), // e.g. "NodeRole.middle"
      'title': title,
      'anchors': anchors.map((a) => a.toJson()).toList(),
      'anchorPadding': anchorPadding.toJson(),
      'status': status.toString(), // e.g. "NodeStatus.running"
      'parentId': parentId,
      'zIndex': zIndex,
      'enabled': enabled,
      'locked': locked,
      'description': description,
      'style': style?.toJson(),
      'version': version,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'inputs': inputs,
      'outputs': outputs,
      'config': config,
      'data': data,
    };
  }

  /// fromJson: 反序列化
  factory NodeModel.fromJson(Map<String, dynamic> json) {
    return NodeModel(
      id: json['id'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      dragMode: _parseDragMode(json['dragMode']),
      type: json['type'] ?? 'default',
      role: _parseNodeRole(json['role']),
      title: json['title'] ?? '',
      anchors: (json['anchors'] as List)
          .map((a) => AnchorModel.fromJson(a))
          .toList(),
      status: _parseNodeStatus(json['status']),
      parentId: json['parentId'] as String?,
      zIndex: _parseZIndex(json['zIndex']),
      enabled: (json['enabled'] is bool) ? json['enabled'] : true,
      locked: (json['locked'] is bool) ? json['locked'] : false,
      description: json['description'] as String?,
      style: _parseNodeStyle(json['style']),
      version: (json['version'] is num) ? (json['version'] as num).toInt() : 1,
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
      inputs: _mapOrEmpty(json['inputs']),
      outputs: _mapOrEmpty(json['outputs']),
      config: _mapOrEmpty(json['config']),
      data: _mapOrEmpty(json['data']),
    );
  }

  // ========== 内部解析函数 ==========

  static DragMode _parseDragMode(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'DragMode.handle':
          return DragMode.handle;
        default:
          return DragMode.full;
      }
    }
    // 如果不是字符串 or 不匹配
    return DragMode.full;
  }

  static NodeRole _parseNodeRole(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'NodeRole.placeholder':
          return NodeRole.placeholder;
        case 'NodeRole.start':
          return NodeRole.start;
        case 'NodeRole.middle':
          return NodeRole.middle;
        case 'NodeRole.end':
          return NodeRole.end;
        case 'NodeRole.custom':
          return NodeRole.custom;
      }
    }
    return NodeRole.middle;
  }

  static NodeStatus _parseNodeStatus(dynamic val) {
    if (val is String) {
      switch (val) {
        case 'NodeStatus.running':
          return NodeStatus.running;
        case 'NodeStatus.completed':
          return NodeStatus.completed;
        case 'NodeStatus.error':
          return NodeStatus.error;
        default:
          return NodeStatus.none;
      }
    }
    return NodeStatus.none;
  }

  static int _parseZIndex(dynamic val) {
    if (val is num) {
      return val.toInt();
    }
    return 0;
  }

  static NodeStyle? _parseNodeStyle(dynamic obj) {
    if (obj is Map<String, dynamic>) {
      return NodeStyle.fromJson(obj);
    }
    return null;
  }

  static DateTime? _parseDateTime(dynamic val) {
    if (val is int) {
      // 使用 millisecondsSinceEpoch => DateTime
      return DateTime.fromMillisecondsSinceEpoch(val);
    }
    // 如果需要支持字符串ISO8601:
    // if (val is String) {
    //   try {
    //     return DateTime.parse(val); // e.g. "2023-01-01T12:00:00Z"
    //   } catch (_) { }
    // }
    return null;
  }

  static Map<String, dynamic> _mapOrEmpty(dynamic obj) {
    if (obj is Map<String, dynamic>) {
      return obj;
    }
    return {};
  }
}
