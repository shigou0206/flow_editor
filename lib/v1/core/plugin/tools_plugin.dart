import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 假设已有 these providers
import 'package:flow_editor/v1/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/v1/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/v1/core/plugin/floating_panel.dart'; // 你之前的FloatingPanel

// 主题模式
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class ToolsPlugin extends ConsumerWidget {
  final NodeBehavior nodeBehavior;
  final double viewportWidth;
  final double viewportHeight;

  const ToolsPlugin({
    super.key,
    required this.nodeBehavior,
    required this.viewportWidth,
    required this.viewportHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);
    final currentMode = ref.watch(themeModeProvider);

    return FloatingPanel(
      // 你自己的小面板组件
      children: [
        // 1) Zoom In
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Zoom In',
          onPressed: () {
            multiCanvasNotifier.zoomAtPoint(1.1, Offset.zero);
          },
        ),

        // 分隔线
        const Divider(height: 1),

        // 2) Zoom Out
        IconButton(
          icon: const Icon(Icons.remove),
          tooltip: 'Zoom Out',
          onPressed: () {
            multiCanvasNotifier.zoomAtPoint(0.9, Offset.zero);
          },
        ),

        const Divider(height: 1),

        // 3) FitView
        IconButton(
          icon: const Icon(Icons.fit_screen),
          tooltip: 'FitView',
          onPressed: () => _fitView(ref),
        ),

        const Divider(height: 1),

        // 4) Theme Toggle
        IconButton(
          icon: Icon(
            currentMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
          ),
          tooltip: currentMode == ThemeMode.dark
              ? 'Switch to Light Mode'
              : 'Switch to Dark Mode',
          onPressed: () {
            ref.read(themeModeProvider.notifier).state =
                currentMode == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark;
          },
        ),
      ],
    );
  }

  void _fitView(WidgetRef ref) {
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);
    final allNodes = nodeBehavior.nodeController.getAllNodes();
    if (allNodes.isEmpty) return;

    double minX = allNodes.first.position.dx;
    double minY = allNodes.first.position.dy;
    double maxX = allNodes.first.position.dx + allNodes.first.size.width;
    double maxY = allNodes.first.position.dy + allNodes.first.size.height;

    for (final node in allNodes) {
      minX = math.min(minX, node.position.dx);
      minY = math.min(minY, node.position.dy);
      maxX = math.max(maxX, node.position.dx + node.size.width);
      maxY = math.max(maxY, node.position.dy + node.size.height);
    }

    const padding = 50.0;
    minX -= padding;
    minY -= padding;
    maxX += padding;
    maxY += padding;

    final contentWidth = maxX - minX;
    final contentHeight = maxY - minY;
    if (contentWidth < 1 || contentHeight < 1) return;

    final newScale = math.min(
      viewportWidth / contentWidth,
      viewportHeight / contentHeight,
    );

    final newOffsetX =
        (viewportWidth - contentWidth * newScale) / 2 - minX * newScale;
    final newOffsetY =
        (viewportHeight - contentHeight * newScale) / 2 - minY * newScale;

    multiCanvasNotifier.setOffset(Offset(newOffsetX, newOffsetY));
    multiCanvasNotifier.setScale(newScale);
  }
}
