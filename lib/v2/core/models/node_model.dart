import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/anchor_model.dart';
import 'package:flow_editor/v2/core/models/enums.dart';
import 'package:flow_editor/v2/core/models/style/node_style.dart';
import 'package:flow_editor/v2/core/utils/anchor_position_utils.dart';

/// 扩展 Offset 和 Size 序列化
extension JsonOffset on Offset {
  Map<String, dynamic> toJson() => {'dx': dx, 'dy': dy};
}

extension JsonSize on Size {
  Map<String, dynamic> toJson() => {'width': width, 'height': height};
}

/// 通用枚举解析
T _parseEnum<T>(
  String? value,
  List<T> values,
  String prefix,
  T defaultValue,
) {
  if (value != null && value.startsWith(prefix)) {
    final name = value.split('.').last;
    for (var v in values) {
      if (v.toString().split('.').last == name) return v;
    }
  }
  return defaultValue;
}

class NodeModel {
  final String id;
  Offset position;
  Size size;
  final DragMode dragMode;
  final String type;
  final NodeRole role;
  final String? title;
  final List<AnchorModel> anchors;
  final bool isGroup;
  final bool isGroupRoot;

  // 扩展字段
  final NodeStatus status;
  final String? parentId;
  final int zIndex;
  final bool enabled;
  final bool locked;
  final String? description;
  final NodeStyle? style;

  // 审计
  final int version;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // 额外动态数据
  final Map<String, dynamic> data;

  NodeModel({
    required this.id,
    required this.position,
    this.size = const Size(100, 30),
    this.dragMode = DragMode.full,
    this.type = '',
    this.role = NodeRole.middle,
    this.title,
    List<AnchorModel>? anchors,
    this.isGroup = false,
    this.isGroupRoot = false,
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
    Map<String, dynamic>? data,
  })  : anchors = anchors ?? const [],
        data = data ?? const {};

  /// 世界坐标下的矩形
  Rect get rect =>
      Rect.fromLTWH(position.dx, position.dy, size.width, size.height);

  AnchorPadding get anchorPadding => computeAnchorPadding(anchors, size);

  NodeModel copyWith({
    Offset? position,
    Size? size,
    DragMode? dragMode,
    String? type,
    NodeRole? role,
    String? title,
    List<AnchorModel>? anchors,
    bool? isGroup,
    bool? isGroupRoot,
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
    Map<String, dynamic>? data,
  }) {
    return NodeModel(
      id: id,
      position: position ?? this.position,
      size: size ?? this.size,
      dragMode: dragMode ?? this.dragMode,
      type: type ?? this.type,
      role: role ?? this.role,
      title: title ?? this.title,
      anchors: anchors ?? this.anchors,
      isGroup: isGroup ?? this.isGroup,
      isGroupRoot: isGroupRoot ?? this.isGroupRoot,
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
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': position.toJson(),
      'size': size.toJson(),
      'dragMode': dragMode.toString(),
      'type': type,
      'role': role.toString(),
      'title': title,
      'anchors': anchors.map((a) => a.toJson()).toList(),
      'isGroup': isGroup,
      'isGroupRoot': isGroupRoot,
      'status': status.toString(),
      'parentId': parentId,
      'zIndex': zIndex,
      'enabled': enabled,
      'locked': locked,
      'description': description,
      'style': style?.toJson(),
      'version': version,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'data': data,
    };
  }

  factory NodeModel.fromJson(Map<String, dynamic> json) {
    return NodeModel(
      id: json['id'] as String,
      position: json['position'] is Map
          ? Offset(
              (json['position']['dx'] as num).toDouble(),
              (json['position']['dy'] as num).toDouble(),
            )
          : Offset.zero,
      size: json['size'] is Map
          ? Size(
              (json['size']['width'] as num).toDouble(),
              (json['size']['height'] as num).toDouble(),
            )
          : Size.zero,
      dragMode: _parseEnum<DragMode>(
        json['dragMode'] as String?,
        DragMode.values,
        'DragMode',
        DragMode.full,
      ),
      type: json['type'] as String? ?? '',
      role: _parseEnum<NodeRole>(
        json['role'] as String?,
        NodeRole.values,
        'NodeRole',
        NodeRole.middle,
      ),
      title: json['title'] as String?,
      anchors: (json['anchors'] as List<dynamic>?)
              ?.map((e) => AnchorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isGroup: json['isGroup'] as bool? ?? false,
      isGroupRoot: json['isGroupRoot'] as bool? ?? false,
      status: _parseEnum<NodeStatus>(
        json['status'] as String?,
        NodeStatus.values,
        'NodeStatus',
        NodeStatus.none,
      ),
      parentId: json['parentId'] as String?,
      zIndex: (json['zIndex'] as num?)?.toInt() ?? 0,
      enabled: json['enabled'] as bool? ?? true,
      locked: json['locked'] as bool? ?? false,
      description: json['description'] as String?,
      style: json['style'] is Map<String, dynamic>
          ? NodeStyle.fromJson(json['style'] as Map<String, dynamic>)
          : null,
      version: (json['version'] as num?)?.toInt() ?? 1,
      createdAt: json['createdAt'] is String
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] is String
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      data: json['data'] as Map<String, dynamic>? ?? {},
    );
  }
}

extension AbsolutePositionExtension on NodeModel {
  Offset absolutePosition(List<NodeModel> allNodes) {
    if (parentId == null) {
      return position;
    } else {
      final parent =
          allNodes.firstWhere((n) => n.id == parentId, orElse: () => this);
      final parentPosition = parent.absolutePosition(allNodes);
      final absolutePosition = parentPosition + position;
      return absolutePosition;
    }
  }
}
