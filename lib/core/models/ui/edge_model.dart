import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/styles/edge_line_style.dart';
import 'package:flow_editor/core/models/styles/edge_animation_config.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';
import 'package:flow_editor/core/models/ui/edge_overlay_element.dart';
import 'package:flow_editor/core/utils/id_generator.dart';
part 'edge_model.freezed.dart';
part 'edge_model.g.dart';

@freezed
class EdgeModel with _$EdgeModel {
  const EdgeModel._();

  const factory EdgeModel({
    required String id,
    @OffsetConverter() Offset? sourcePosition,
    @OffsetConverter() Offset? targetPosition,

    // ===== 连接信息 =====
    String? sourceNodeId,
    String? sourceAnchorId,
    @Default("none") String? targetNodeId,
    @Default("none") String? targetAnchorId,
    @Default(false) bool isConnected,
    @Default(true) bool isDirected,

    // ===== 分类与状态 =====
    @Default("default") String edgeType,
    String? status,
    @Default(false) bool locked,
    String? lockedByUser,
    @Default(1) int version,
    @Default(0) int zIndex,

    // ===== 路由点 =====
    @OffsetListConverter() List<Offset>? waypoints,

    // ===== 样式 & 动画 =====
    @Default(EdgeLineStyle()) EdgeLineStyle lineStyle,
    @Default(EdgeAnimationConfig()) EdgeAnimationConfig animConfig,

    // ===== 标签 =====
    String? label,
    Map<String, dynamic>? labelStyle,

    // ===== 扩展交互元素 =====
    @Default([]) List<EdgeOverlayElement> overlays,

    // ===== 附加数据 =====
    @Default({}) Map<String, dynamic> data,
    @Default({}) Map<String, dynamic> metadata,
  }) = _EdgeModel;

  factory EdgeModel.fromJson(Map<String, dynamic> json) =>
      _$EdgeModelFromJson(json);

  /// 自定义 id 生成逻辑（替代构造函数中赋值）
  factory EdgeModel.generated({
    String? sourceNodeId,
    String? targetNodeId,
    String? sourceAnchorId,
    String? targetAnchorId,
    String? label,
    bool isDirected = true,
    Map<String, dynamic>? extra,
  }) {
    final id = IdGenerator.generateEdgeId(
      sourceNodeId,
      targetNodeId,
      sourceAnchorId,
      targetAnchorId,
      label,
      isDirected: isDirected,
    );
    return EdgeModel(
      id: id,
      sourceNodeId: sourceNodeId,
      targetNodeId: targetNodeId,
      sourceAnchorId: sourceAnchorId,
      targetAnchorId: targetAnchorId,
      isDirected: isDirected,
      data: extra ?? const {},
    );
  }
}
