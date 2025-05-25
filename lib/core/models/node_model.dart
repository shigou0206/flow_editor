import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/enums/node_enums.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/styles/node_style.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';

part 'node_model.freezed.dart';
part 'node_model.g.dart';

@freezed
class NodeModel with _$NodeModel {
  const NodeModel._(); // for computed properties

  const factory NodeModel({
    required String id,
    @OffsetConverter() @Default(Offset.zero) Offset position,
    @SizeConverter() @Default(Size(200, 40)) Size size,
    @Default(DragMode.full) DragMode dragMode,
    @Default('') String type,
    @Default(NodeRole.middle) NodeRole role,
    String? title,
    @Default([]) List<AnchorModel> anchors,
    @Default(false) bool isGroup,
    @Default(false) bool isGroupRoot,
    @Default([]) List<NodeModel> children,
    @Default([]) List<String> outgoingEdgeIds,
    @Default([]) List<String> incomingEdgeIds,
    @Default(NodeStatus.none) NodeStatus status,
    String? parentId,
    @Default(0) int zIndex,
    @Default(true) bool enabled,
    @Default(false) bool locked,
    String? description,
    NodeStyle? style,
    @Default(1) int version,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default({}) Map<String, dynamic> inputs,
    @Default({}) Map<String, dynamic> outputs,
    @Default({}) Map<String, dynamic> config,
    @Default({}) Map<String, dynamic> data,
    @Default({}) Map<String, dynamic> metadata,
  }) = _NodeModel;

  factory NodeModel.fromJson(Map<String, dynamic> json) =>
      _$NodeModelFromJson(json);

  Rect get rect =>
      Rect.fromLTWH(position.dx, position.dy, size.width, size.height);

  double get totalWidth =>
      size.width + anchorPadding.left + anchorPadding.right;
  double get totalHeight =>
      size.height + anchorPadding.top + anchorPadding.bottom;

  AnchorPadding get anchorPadding => computeAnchorPadding(anchors, size);

  void doLayout() {
    // placeholder
  }
}

extension NodeModelExtension on NodeModel {
  Offset absolutePosition(List<NodeModel> allNodes) {
    if (parentId == null) return position;

    final parent = allNodes.firstWhere((n) => n.id == parentId);
    return position + parent.absolutePosition(allNodes);
  }
}
