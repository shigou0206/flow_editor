import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/v2/core/types/position_enum.dart';
import 'package:flow_editor/v2/core/types/anchor_enums.dart';

part 'anchor_model.freezed.dart';
part 'anchor_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true, createFactory: false)
class AnchorModel with _$AnchorModel {
  // Private constructor for creating an immutable AnchorModel instance
  const AnchorModel._();

  // Factory constructor for creating an immutable AnchorModel instance
  const factory AnchorModel({
    // Unique identifier for the anchor
    required String id,
    // Width of the anchor
    required double width,
    // Height of the anchor
    required double height,
    // Position of the anchor, defined by an enum
    required Position position,
    // Ratio for positioning, default is 0.5
    @Default(0.5) double ratio,
    // Direction of the anchor, default is inout
    @Default(AnchorDirection.inout) AnchorDirection direction,
    // Maximum number of connections allowed, optional
    int? maxConnections,
    // List of accepted edge types for connections, optional
    List<String>? acceptedEdgeTypes,
    // Shape of the anchor, default is circle
    @Default(AnchorShape.circle) AnchorShape shape,
    // Direction of the arrow, default is none
    @Default(ArrowDirection.none) ArrowDirection arrowDirection,
    // Indicates if the anchor is locked, default is false
    @Default(false) bool locked,
    // Version of the anchor model, default is 1
    @Default(1) int version,
    // User who locked the anchor, optional
    String? lockedByUser,
    // Hex color code for the plus button, optional
    String? plusButtonColorHex,
    // Size of the plus button, optional
    double? plusButtonSize,
    // Name of the icon associated with the anchor, optional
    String? iconName,
    // Additional data associated with the anchor, default is an empty map
    @Default({}) Map<String, dynamic> data,
    // Placement of the anchor, default is border
    @Default(AnchorPlacement.border) AnchorPlacement placement,
    // Offset distance for the anchor, default is 0.0
    @Default(0.0) double offsetDistance,
    // Angle of the anchor, default is 0.0
    @Default(0.0) double angle,
    // Identifier of the node to which the anchor belongs
    required String nodeId,
  }) = _AnchorModel;

  // Factory method for creating an AnchorModel instance from a JSON map
  factory AnchorModel.fromJson(Map<String, dynamic> json) =>
      _$AnchorModelFromJson(json);
}
