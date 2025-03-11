import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/canvas/models/canvas_visual_config.dart';
import 'core/graph_editor/graph_editor.dart';
import 'core/node/controllers/node_controller.dart';
import 'core/edge/controllers/edge_controller.dart';
import 'core/canvas/controllers/canvas_controller.dart';
import 'core/canvas/behaviors/default_canvas_behavior.dart';
import 'core/edge/behaviors/default_edge_behavior.dart';
import 'core/node/behaviors/default_node_behavior.dart';
import 'core/anchor/behaviors/default_anchor_behavior.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const workflowId = 'workflow1';

    final nodeController = NodeController(
      container: ProviderScope.containerOf(context),
      workflowId: workflowId,
    );

    final edgeController = EdgeController(
      container: ProviderScope.containerOf(context),
      workflowId: workflowId,
    );

    final canvasController = CanvasController(
      ref: ref,
      context: context,
    );

    final nodeBehavior = DefaultNodeBehavior(
      nodeController: nodeController,
    );

    final edgeBehavior = DefaultEdgeBehavior(
      edgeController: edgeController,
    );

    final anchorBehavior = DefaultAnchorBehavior(
      workflowId: workflowId,
      nodeController: nodeController,
      edgeController: edgeController,
    );

    final canvasBehavior = DefaultCanvasBehavior(
      controller: canvasController,
    );

    const canvasConfig = CanvasVisualConfig(
      backgroundColor: Colors.white,
      showGrid: true,
      gridColor: Colors.grey,
      gridSpacing: 20,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GraphEditor(
          workflowId: workflowId,
          nodeBehavior: nodeBehavior,
          edgeBehavior: edgeBehavior,
          anchorBehavior: anchorBehavior,
          visualConfig: canvasConfig,
          canvasBehavior: canvasBehavior,
        ),
      ),
    );
  }
}
