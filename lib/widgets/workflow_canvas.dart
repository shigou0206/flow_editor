// lib/widgets/workflow_canvas.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
import 'package:flow_editor/core/state_management/providers/theme_provider.dart';
import 'package:flow_editor/core/state_management/providers/node_state_provider.dart';
import 'package:flow_editor/core/models/style/grid_style.dart';

import 'package:flow_editor/core/painters/background_painter.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/enums.dart';
import 'package:flow_editor/widgets/commons/node_widget.dart';

class WorkflowCanvas extends ConsumerStatefulWidget {
  const WorkflowCanvas({super.key, required this.workflowId});
  final String workflowId;

  @override
  ConsumerState<WorkflowCanvas> createState() => _WorkflowCanvasState();
}

class _WorkflowCanvasState extends ConsumerState<WorkflowCanvas> {
  String? _dragNodeId;

  // 简易 id 生成
  String _genId() => DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    final geom = ref.watch(canvasGeomProvider(widget.workflowId));
    final appTheme = ref.watch(themeProvider);
    final nodes = ref.watch(nodesProvider(widget.workflowId));

    return Stack(
      children: [
        // ── 背景 + 手势 ──
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onScaleStart: (details) {
            // 触点 → world 坐标
            final world = (details.localFocalPoint - geom.offset) / geom.scale;

            // 命中测试节点
            for (final n in nodes.reversed) {
              final rect = Rect.fromCenter(
                  center: n.position,
                  width: n.size.width,
                  height: n.size.height);
              if (rect.contains(world)) {
                _dragNodeId = n.id;
                return;
              }
            }
            _dragNodeId = null;
          },
          onScaleUpdate: (details) {
            if (_dragNodeId != null && details.scale == 1.0) {
              // 拖节点
              ref
                  .read(nodeStateProvider(widget.workflowId).notifier)
                  .move(_dragNodeId!, details.focalPointDelta / geom.scale);
              return;
            }

            // 画布平移 / 缩放
            final g = ref.read(canvasGeomProvider(widget.workflowId).notifier);
            if (details.scale == 1.0) {
              g.pan(-details.focalPointDelta);
            } else {
              g.zoom(details.scale);
            }
          },
          onScaleEnd: (_) => _dragNodeId = null,
          child: CustomPaint(
            size: Size.infinite,
            foregroundPainter: CanvasBackgroundPainter(
              offset: geom.offset,
              scale: geom.scale,
              bgColor: appTheme == AppTheme.dark ? Colors.black : Colors.white,
              grid: const GridStyle(
                show: true,
                style: BackgroundStyle.dots,
                spacing: 10,
                dotRadius: 2,
                mainColor: Colors.white,
                subColor: Colors.black,
              ),
            ),
          ),
        ),

        // ── 节点层 ──
        ...nodes.map(
          (n) => NodeWidget(
            key: ValueKey(n.id),
            node: n,
            child: Text(n.title ?? 'Node'),
          ),
        ),

        // ── 主题切换按钮 ──
        Positioned(
          right: 16,
          bottom: 72,
          child: FloatingActionButton.small(
            heroTag: 'theme_${widget.workflowId}',
            backgroundColor:
                appTheme == AppTheme.dark ? Colors.white : Colors.black,
            foregroundColor:
                appTheme == AppTheme.dark ? Colors.black : Colors.white,
            onPressed: () => ref.read(themeProvider.notifier).toggle(),
            child: Icon(
              appTheme == AppTheme.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
          ),
        ),

        // ── 添加节点按钮 ──
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            heroTag: 'add_${widget.workflowId}',
            tooltip: 'Add node',
            onPressed: () {
              final Size screen = MediaQuery.of(context).size;
              final centerWorld =
                  (Offset(screen.width / 2, screen.height / 2) - geom.offset) /
                      geom.scale;

              ref.read(nodeStateProvider(widget.workflowId).notifier).add(
                    NodeModel(
                      id: _genId(),
                      position: centerWorld,
                      title: 'Node',
                    ),
                  );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
