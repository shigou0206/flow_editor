import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';
import 'package:flow_editor/core/node/models/styles/node_style.dart';

enum ShapeType { rectangle, circle, diamond, ellipse }

class ShapeNodeModel extends NodeModel {
  final ShapeType shapeType;
  final String label;
  final Color color;

  ShapeNodeModel({
    required super.id,
    required super.position,
    required super.size,
    required this.shapeType,
    required super.title,
    this.label = '',
    this.color = Colors.blue,
    super.anchors = const [],
    super.isGroup = false,
    super.isGroupRoot = false,
    super.type = 'shape',
    super.dragMode,
    super.role,
    super.status,
    super.parentId,
    super.zIndex,
    super.enabled,
    super.locked,
    super.description,
    super.style,
    super.version,
    super.createdAt,
    super.updatedAt,
    super.inputs,
    super.outputs,
    super.config,
    super.data,
  });

  @override
  ShapeNodeModel copyWith({
    ShapeType? shapeType,
    String? label,
    Color? color,
    String? title,
    Offset? position,
    Size? size,
    List<AnchorModel>? anchors,
    AnchorPadding? anchorPadding,
    bool? isGroup,
    bool? isGroupRoot,
    DragMode? dragMode,
    NodeRole? role,
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
    String? type,
  }) {
    return ShapeNodeModel(
      id: id,
      position: position ?? this.position,
      size: size ?? this.size,
      shapeType: shapeType ?? this.shapeType,
      label: label ?? this.label,
      color: color ?? this.color,
      title: title ?? this.title,
      anchors: anchors ?? this.anchors,
      isGroup: isGroup ?? this.isGroup,
      isGroupRoot: isGroupRoot ?? this.isGroupRoot,
      dragMode: dragMode ?? this.dragMode,
      role: role ?? this.role,
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
      type: type ?? this.type,
    );
  }
}
