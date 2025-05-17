// lib/widgets/canvas_background.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
import 'package:flow_editor/core/state_management/providers/theme_provider.dart';
import 'package:flow_editor/core/models/enums.dart';
import 'package:flow_editor/core/painters/background_painter.dart';
import 'package:flow_editor/core/models/style/grid_style.dart';

class CanvasBackground extends ConsumerWidget {
  const CanvasBackground({super.key, required this.workflowId});

  final String workflowId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geom = ref.watch(canvasGeomProvider(workflowId));
    final visual = ref.watch(canvasVisualProvider(workflowId));
    final theme = ref.watch(themeProvider);

    // 背景底色
    final bgColor = switch (theme) {
      AppTheme.dark => const Color(0xFF1E1E1E),
      AppTheme.sepia => const Color(0xFFF3E9D2),
      AppTheme.ocean => const Color(0xFFE0F7FA),
      _ => Colors.white,
    };

    final baseColor =
        theme == AppTheme.dark ? visual.gridColorDark : visual.gridColorLight;

    final gridStyle = GridStyle(
      show: visual.showGrid,
      style: visual.bgStyle,
      spacing: visual.spacing,
      dotRadius: visual.dotRadius,
      mainColor: baseColor.withOpacity(visual.lineOpacityMain),
      subColor: baseColor.withOpacity(visual.lineOpacitySub),
    );

    return RepaintBoundary(
      child: CustomPaint(
        size: Size.infinite,
        painter: CanvasBackgroundPainter(
          offset: geom.offset,
          scale: geom.scale,
          bgColor: bgColor,
          grid: gridStyle,
        ),
      ),
    );
  }
}
