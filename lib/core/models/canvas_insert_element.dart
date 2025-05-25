import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';

part 'canvas_insert_element.freezed.dart';
part 'canvas_insert_element.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class CanvasInsertElement with _$CanvasInsertElement {
  const factory CanvasInsertElement.node({
    @OffsetConverter() required Offset position,
    @SizeConverter() required Size size,
    required NodeModel node,
  }) = NodeInsertElement;

  const factory CanvasInsertElement.group({
    @OffsetConverter() required Offset position,
    @SizeConverter() required Size size,
    required NodeModel groupNode,
    required List<NodeModel> children,
    required List<EdgeModel> edges,
  }) = GroupInsertElement;

  factory CanvasInsertElement.fromJson(Map<String, dynamic> json) =>
      _$CanvasInsertElementFromJson(json);
}

extension CanvasInsertElementX on CanvasInsertElement {
  bool get isNode => map(node: (_) => true, group: (_) => false);

  bool get isGroup => map(node: (_) => false, group: (_) => true);

  NodeModel? get singleNode => map(
        node: (data) => data.node,
        group: (_) => null,
      );

  NodeModel? get rootGroupNode => map(
        node: (_) => null,
        group: (data) => data.groupNode,
      );

  List<NodeModel> get allNodes => map(
        node: (data) => [data.node],
        group: (data) => [data.groupNode, ...data.children],
      );

  List<EdgeModel> get allEdges => map(
        node: (_) => [],
        group: (data) => data.edges,
      );

  CanvasInsertElement moveTo(Offset newPosition) => map(
        node: (data) => data.copyWith(position: newPosition),
        group: (data) => data.copyWith(position: newPosition),
      );

  Rect calculateBoundingBox() => map(
        node: (data) => data.position & data.node.size,
        group: (data) {
          if (data.children.isEmpty) {
            return data.position & data.groupNode.size;
          }

          final childRects = data.children
              .map((child) => (data.position + child.position) & child.size)
              .toList();

          return childRects.reduce((a, b) => a.expandToInclude(b));
        },
      );
}
