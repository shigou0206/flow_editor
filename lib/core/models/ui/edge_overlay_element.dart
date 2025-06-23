import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/enums/edge_enums.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';
part 'edge_overlay_element.freezed.dart';
part 'edge_overlay_element.g.dart';

/// Overlay 表示附着在 Edge 路径上的 UI 元素（如标签、按钮、图标）
@freezed
class EdgeOverlayElement with _$EdgeOverlayElement {
  const factory EdgeOverlayElement({
    required String id, // 唯一标识（可用于编辑或点击）
    required String type, // 'label', 'button:add', 'icon:warn'...

    /// 路径上的相对位置（0.0 ~ 1.0）
    @Default(0.5) double positionRatio,

    /// 相对于路径切线方向的偏移方向（上/下/左/右）
    @Default(OverlayDirection.above) OverlayDirection direction,

    /// 偏移量（单位：像素）
    @OffsetConverter() @Default(Offset.zero) Offset offset,

    /// 元素的尺寸（用于布局和 hitTest）
    @SizeConverter() Size? size,

    /// 附加数据
    Map<String, dynamic>? data,
  }) = _EdgeOverlayElement;

  factory EdgeOverlayElement.fromJson(Map<String, dynamic> json) =>
      _$EdgeOverlayElementFromJson(json);
}
