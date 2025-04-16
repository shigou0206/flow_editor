// lib/flow_editor/core/graph_editor/graph_editor_canvas.dart
import 'package:flutter/material.dart';
import 'package:flow_editor/core/canvas/interaction/gesture_event_handler.dart';
import 'package:flow_editor/core/canvas/interaction/mouse_event_handler.dart';
import 'package:flow_editor/core/canvas/widgets/canvas_widget.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state.dart';
import 'package:flow_editor/core/drag_drop/widgets/generic_drop_target.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/graph_editor/graph_editor.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory.dart';

class GraphEditorCanvas extends StatelessWidget {
  final CanvasState canvasState;
  final String workflowId;
  final NodeBehavior nodeBehavior; // 保留类型你的 NodeBehavior
  final EdgeBehavior edgeBehavior;
  final AnchorBehavior anchorBehavior;
  final CanvasVisualConfig visualConfig; // CanvasVisualConfig 类型
  final CanvasBehavior canvasBehavior;
  final NodeWidgetFactory nodeFactory; // NodeWidgetFactory 类型

  const GraphEditorCanvas({
    super.key,
    required this.canvasState,
    required this.workflowId,
    required this.nodeBehavior,
    required this.edgeBehavior,
    required this.anchorBehavior,
    required this.visualConfig,
    required this.canvasBehavior,
    required this.nodeFactory,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1200,
        height: 800,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2)),
        child: ClipRect(
          child: GenericDropTarget<NodeModel>(
            onWillAccept: (data) => data != null,
            onAcceptWithPosition: (nodeTemplate, dropPosition) {
              final newId = 'node_${DateTime.now().millisecondsSinceEpoch}';
              // 此处，你可能需要加入构造 anchors 等逻辑
              final newNode = NodeModel(
                id: newId,
                type: nodeTemplate.type,
                role: nodeTemplate.role,
                position: dropPosition,
                size: nodeTemplate.size,
                title: nodeTemplate.title,
                anchors: [
                  AnchorModel(
                    id: 'out_$newId',
                    nodeId: newId,
                    position: Position.right,
                    placement: AnchorPlacement.border,
                    offsetDistance: 0,
                    ratio: 0.65,
                    width: 24,
                    height: 24,
                    shape: AnchorShape.diamond,
                  ),
                  AnchorModel(
                    id: 'in_$newId',
                    nodeId: newId,
                    position: Position.left,
                    placement: AnchorPlacement.border,
                    offsetDistance: 0,
                    ratio: 0.65,
                    width: 24,
                    height: 24,
                    shape: AnchorShape.square,
                  ),
                ],
              );
              // 业务层可直接调用 nodeBehavior.nodeController.upsertNode(newNode);
              nodeBehavior.nodeController.upsertNode(newNode);
            },
            // 如需考虑 canvasState 的 offset 与 scale，上层可在此传入 transformOffset
            transformOffset: (globalOffset) {
              final renderBox = context.findRenderObject() as RenderBox;
              final localOffset = renderBox.globalToLocal(globalOffset);
              return Offset(
                (localOffset.dx - canvasState.offset.dx) / canvasState.scale,
                (localOffset.dy - canvasState.offset.dy) / canvasState.scale,
              );
            },
            builder: (context, isDraggingOver, child) {
              return Container(
                  color: isDraggingOver ? Colors.grey[300] : Colors.white,
                  child: child);
            },
            child: CanvasMouseHandler(
              child: CanvasGestureHandler(
                behavior: canvasBehavior,
                child: CanvasWidget(
                  workflowId: workflowId,
                  visualConfig: visualConfig,
                  canvasGlobalKey: GraphEditor.canvasStackKey,
                  offset: canvasState.offset,
                  scale: canvasState.scale,
                  nodeBehavior: nodeBehavior,
                  edgeBehavior: edgeBehavior,
                  anchorBehavior: anchorBehavior,
                  nodeWidgetFactory: nodeFactory,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
