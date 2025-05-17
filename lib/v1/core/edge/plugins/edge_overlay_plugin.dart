import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';

/// EdgeOverlayPlugin: 定义了为“某条已连接的边”构建一批 Overlay Widget 的能力
abstract class EdgeOverlayPlugin {
  /// 当画布渲染时，会调用此方法，为 [edge] 生成交互 Overlays
  /// [screenOffsetConvert]: 用于把“世界坐标” => “屏幕坐标”
  /// [scale]: 当前画布缩放
  List<Widget> buildEdgeOverlays({
    required EdgeModel edge,
    required Offset Function(Offset) screenOffsetConvert,
    required double scale,
  });
}
