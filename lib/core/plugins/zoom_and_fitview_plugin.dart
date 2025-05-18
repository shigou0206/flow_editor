import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
import 'package:flow_editor/del/behaviors/node_behavior.dart';

/// ZoomAndFitViewPlugin：
/// - 提供"Zoom In / Zoom Out / Fit View"按键
/// - 使用 multiCanvasStateProvider 来控制画布的缩放与平移
/// - 从 nodeBehavior.nodeController 里获取所有节点，计算 bounding box 做 FitView
class ZoomAndFitViewPlugin extends ConsumerWidget {
  final NodeBehavior nodeBehavior;
  final double viewportWidth;
  final double viewportHeight;

  const ZoomAndFitViewPlugin({
    super.key,
    required this.nodeBehavior,
    required this.viewportWidth,
    required this.viewportHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);

    return Card(
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Zoom In',
            onPressed: () {
              // 以Offset.zero为中心放大
              multiCanvasNotifier.zoomAtPoint(1.1, Offset.zero);
            },
          ),
          const Divider(height: 1),
          IconButton(
            icon: const Icon(Icons.remove),
            tooltip: 'Zoom Out',
            onPressed: () {
              multiCanvasNotifier.zoomAtPoint(0.9, Offset.zero);
            },
          ),
          const Divider(height: 1),
          IconButton(
            icon: const Icon(Icons.fit_screen),
            tooltip: 'Fit View',
            onPressed: () => _fitView(ref),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  /// 计算节点 bounding box 并让画布居中显示
  void _fitView(WidgetRef ref) {
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);
    final nodeController = nodeBehavior.nodeController;

    // 1. 获取全部节点
    final allNodes = nodeController.getAllNodes();
    if (allNodes.isEmpty) return;

    // 2. 计算最小包围盒
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

    // 3. 额外留白
    const double padding = 50.0;
    minX -= padding;
    minY -= padding;
    maxX += padding;
    maxY += padding;
    final contentWidth = maxX - minX;
    final contentHeight = maxY - minY;

    // 若太小，也可加保护
    if (contentWidth < 1 || contentHeight < 1) return;

    // 4. 根据画布视口大小 计算新的 scale
    final newScale = math.min(
      viewportWidth / contentWidth,
      viewportHeight / contentHeight,
    );

    // 5. 计算新的 offset 让包围盒居中
    //   先让最左上角映射到(0,0)，再让它居中
    final newOffsetX =
        (viewportWidth - contentWidth * newScale) / 2 - minX * newScale;
    final newOffsetY =
        (viewportHeight - contentHeight * newScale) / 2 - minY * newScale;

    // 6. 更新 multiCanvasState
    //   multiCanvasNotifier有 setOffset, setScale, panBy, zoomAtPoint 等方法
    //   但需要你在 multiCanvasStateProvider.notifier 里写对应接口
    multiCanvasNotifier.setOffset(Offset(newOffsetX, newOffsetY));
    multiCanvasNotifier.setScale(newScale);

    // 你也可以先 multiCanvasNotifier.setScale(newScale),
    // 然后 multiCanvasNotifier.setOffset(newOffsetX, newOffsetY)
    // 看具体方法签名
  }
}
