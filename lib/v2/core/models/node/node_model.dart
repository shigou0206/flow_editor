import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/v2/core/models/anchor/anchor_model.dart';
import 'package:flow_editor/v2/core/types/node_enums.dart';
import 'package:flow_editor/v2/core/models/node/node_style.dart';
import 'package:flow_editor/v2/core/models/common/converters.dart';
import 'package:flow_editor/v2/core/utils/anchor_utils.dart';

part 'node_model.freezed.dart';
part 'node_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true, createFactory: false)
class NodeModel with _$NodeModel {
  const NodeModel._();

  const factory NodeModel({
    required String id,
    @OffsetConverter() required Offset position,
    @SizeConverter() required Size size,
    @Default('') String type,
    String? title,
    @Default([]) List<AnchorModel> anchors,
    @Default(false) bool isGroup,
    @Default(false) bool isGroupRoot,
    @Default(NodeStatus.none) NodeStatus status,
    String? parentId,
    @Default(0) int zIndex,
    @Default(true) bool enabled,
    @Default(false) bool locked,
    String? description,
    NodeStyle? style,
    @Default(1) int version,
    @DateTimeEpochConverter() DateTime? createdAt,
    @DateTimeEpochConverter() DateTime? updatedAt,
    @Default(<String, dynamic>{}) Map<String, dynamic> data,
  }) = _NodeModel;

  factory NodeModel.fromJson(Map<String, dynamic> json) =>
      _$NodeModelFromJson(json);
}

extension NodeModelLayoutUtils on NodeModel {
  AnchorPadding get anchorPadding => computeAnchorPadding(anchors, size);

  double get totalWidth =>
      size.width + anchorPadding.left + anchorPadding.right;

  double get totalHeight =>
      size.height + anchorPadding.top + anchorPadding.bottom;

  Rect get rect =>
      Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
}

extension NodeModelPositionUtils on NodeModel {
  Offset absolutePosition(List<NodeModel> allNodes) {
    if (parentId == null) return position;

    final parent = allNodes.firstWhere(
      (n) => n.id == parentId,
      orElse: () => this,
    );
    return parent.absolutePosition(allNodes) + position;
  }
}
