import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/canvas/models/canvas_visual_config.dart';
import 'core/canvas/graph_editor.dart';
import 'core/node/controllers/node_controller.dart';
import 'core/edge/controllers/edge_controller.dart';
import 'core/canvas/behaviors/default_canvas_behavior.dart';
import 'core/edge/behaviors/default_edge_behavior.dart';

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
      behavior: DefaultEdgeBehavior(),
    );

    final canvasBehavior = DefaultCanvasBehavior(ref);

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
          nodeController: nodeController,
          edgeController: edgeController,
          visualConfig: canvasConfig,
          canvasBehavior: canvasBehavior,
        ),
      ),
    );
  }
}
