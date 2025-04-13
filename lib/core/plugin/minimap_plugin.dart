// lib/plugins/minimap_plugin.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/plugin/utils.dart';

class MinimapPlugin extends ConsumerWidget {
  final double width;
  final double height;
  final String workflowId;

  const MinimapPlugin({
    super.key,
    this.width = 200.0,
    this.height = 150.0,
    required this.workflowId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minimapWidth = width;
    final minimapHeight = height;

    // 获取节点和画布边界
    final nodes = ref.watch(nodeStateProvider(workflowId)).nodesOf(workflowId);
    final Rect contentBounds = computeContentBounds(nodes);
    final Offset contentOrigin = contentBounds.topLeft;

    // 获取当前缩放 & 偏移
    final canvasState = ref.watch(multiCanvasStateProvider).activeState;
    final Offset controllerOffset = canvasState.offset;
    final double controllerScale = canvasState.scale;

    // 计算 Minimap 的缩放因子
    final double scaleFactor = math.min(
      minimapWidth / contentBounds.width,
      minimapHeight / contentBounds.height,
    );

    // 计算 Minimap 视口
    final double logicalViewportWidth =
        canvasState.visualConfig.width / controllerScale;
    final double logicalViewportHeight =
        canvasState.visualConfig.height / controllerScale;
    final Offset logicalViewportOrigin = controllerOffset - contentOrigin;

    double miniOffsetX = logicalViewportOrigin.dx * scaleFactor;
    double miniOffsetY = logicalViewportOrigin.dy * scaleFactor;
    final double miniViewportWidth = logicalViewportWidth * scaleFactor;
    final double miniViewportHeight = logicalViewportHeight * scaleFactor;

    // 约束视口边界
    miniOffsetX =
        miniOffsetX.clamp(0.0, math.max(0.0, minimapWidth - miniViewportWidth));
    miniOffsetY = miniOffsetY.clamp(
        0.0, math.max(0.0, minimapHeight - miniViewportHeight));

    return Align(
      alignment: Alignment.bottomRight, // 代替 Positioned
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: minimapWidth,
          height: minimapHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // 网格背景
              CustomPaint(
                size: Size(minimapWidth, minimapHeight),
                painter: GridPainter(),
              ),
              // 绘制所有节点缩略图
              for (final node in nodes)
                Positioned(
                  left: (node.position.dx - contentOrigin.dx) * scaleFactor,
                  top: (node.position.dy - contentOrigin.dy) * scaleFactor,
                  width: node.size.width * scaleFactor,
                  height: node.size.height * scaleFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              // 视口指示器
              Positioned(
                left: miniOffsetX,
                top: miniOffsetY,
                width: miniViewportWidth,
                height: miniViewportHeight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 添加网格绘制器
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..strokeWidth = 1;

    const spacing = 20.0;

    // 绘制垂直线
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i, size.height),
        paint,
      );
    }

    // 绘制水平线
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
