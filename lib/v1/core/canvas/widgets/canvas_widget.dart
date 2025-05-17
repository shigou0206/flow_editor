import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/v1/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/v1/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/v1/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/v1/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/v1/core/canvas/renderers/canvas_renderer.dart';
import 'package:flow_editor/v1/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/v1/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/v1/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/v1/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/v1/core/node/factories/node_widget_factory.dart';
import 'package:flow_editor/v1/core/edge/plugins/edge_overlay_plugin.dart';

/// CanvasWidget(插件机制版):
/// - 基于原先 CanvasWidget，
/// - 用 Stack(children: [...]) 叠加画布 + 可选插件。
/// - 外部可在 plugins 里传一批 Widget(如 Positioned(...) 小地图/缩放工具等)
class CanvasWidget extends ConsumerWidget {
  final String workflowId; // 唯一标识某个工作流

  final CanvasVisualConfig visualConfig; // 画布视觉配置
  final GlobalKey canvasGlobalKey; // 若需要 globalToLocal，可供外部使用
  final Offset offset; // 当前平移量
  final double scale; // 当前缩放因子

  final NodeWidgetFactory nodeWidgetFactory;

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;
  final EdgeBehavior? edgeBehavior;
  final CanvasBehavior? canvasBehavior;

  /// 原有的 edgePlugins, 如果要保留
  final List<EdgeOverlayPlugin>? edgePlugins;

  /// 新增：一批可叠加在画布之上的插件 Widget
  final List<Widget> plugins;

  const CanvasWidget({
    super.key,
    required this.workflowId,
    required this.visualConfig,
    required this.canvasGlobalKey,
    this.offset = Offset.zero,
    this.scale = 1.0,
    required this.nodeWidgetFactory,
    this.nodeBehavior,
    this.anchorBehavior,
    this.edgeBehavior,
    this.canvasBehavior,
    this.edgePlugins,
    this.plugins = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. watch state
    final nodeState = ref.watch(nodeStateProvider(workflowId));
    final edgeState = ref.watch(edgeStateProvider(workflowId));
    final hoveredEdgeId = ref.watch(multiCanvasStateProvider).hoveredEdgeId;

    // 2. 用Stack叠加：
    //   - 底层: 画布( CanvasRenderer )
    //   - 中层: (可选) EdgePlugins Overlay
    //   - 顶层: 用户自定义传进来的 plugins
    return Stack(
      children: [
        // ========== 画布本体 ========== //
        SizedBox(
          key: canvasGlobalKey,
          child: CanvasRenderer(
            workflowId: workflowId,
            offset: offset,
            scale: scale,
            nodeWidgetFactory: nodeWidgetFactory,
            nodeState: nodeState,
            edgeState: edgeState,
            visualConfig: visualConfig,
            nodeBehavior: nodeBehavior,
            anchorBehavior: anchorBehavior,
            edgeBehavior: edgeBehavior,
            canvasBehavior: canvasBehavior,
            hoveredEdgeId: hoveredEdgeId,
            edgePlugins: edgePlugins ?? const [],
          ),
        ),

        // ========== 最顶层: 用户自定义插件 ========== //
        // plugins 里可以包含 Positioned(...) 之类
        if (plugins.isNotEmpty) ...plugins,
      ],
    );
  }
}
