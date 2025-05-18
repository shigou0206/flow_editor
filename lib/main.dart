import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/models/styles/canvas_visual_config.dart';
import 'graph_editor/graph_editor.dart';
import 'del/controllers/node_controller.dart';
import 'del/controllers/edge_controller.dart';
import 'del/controllers/canvas_controller.dart';
import 'del/behaviors/default_canvas_behavior.dart';
import 'del/behaviors/default_edge_behavior.dart';
import 'del/behaviors/default_node_behavior.dart';
import 'del/behaviors/default_anchor_behavior.dart';

// ------------------- Providers -------------------
import 'package:flow_editor/core/plugins/tools_plugin.dart';

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

    final currentMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: currentMode,
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
