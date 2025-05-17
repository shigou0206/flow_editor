import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/models/canvas_visual.dart';
import 'package:flow_editor/core/models/enums.dart';

class CanvasVisualNotifier extends StateNotifier<CanvasVisual> {
  CanvasVisualNotifier() : super(const CanvasVisual());

  // Grid 开关
  void toggleGrid() => state = state.copyWith(showGrid: !state.showGrid);

  // 背景样式
  void setBgStyle(BackgroundStyle style) =>
      state = state.copyWith(bgStyle: style); // ←★

  // 调整网格间距 (8~200)
  void setSpacing(double px) =>
      state = state.copyWith(spacing: px.clamp(8, 200));

  // 调整点半径 (0.5~5)
  void setDotRadius(double r) =>
      state = state.copyWith(dotRadius: r.clamp(0.5, 5));

  // 调整浅色 / 深色主题下网格颜色
  void setGridColorLight(Color c) => state = state.copyWith(gridColorLight: c);
  void setGridColorDark(Color c) => state = state.copyWith(gridColorDark: c);

  // 调整线透明度
  void setLineOpacity({double? main, double? sub}) => state = state.copyWith(
        lineOpacityMain: main ?? state.lineOpacityMain,
        lineOpacitySub: sub ?? state.lineOpacitySub,
      );
}
