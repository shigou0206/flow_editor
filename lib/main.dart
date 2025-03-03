// file: main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 请根据你的项目结构调整导入路径
import 'core/canvas/models/canvas_visual_config.dart';
import 'core/canvas/graph_editor.dart';
import 'core/node/controllers/node_controller.dart'; // 你已有的 NodeController
import 'core/edge/controllers/edge_controller.dart'; // 假设也有个 EdgeController
import 'core/edge/behaviors/default_edge_behavior.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final container = ProviderScope.containerOf(context);
    // 你可在这里自定义画布的一些外观配置

    final nodeController = NodeController(
      container: container,
      workflowId: 'workflow1',
    );

    final edgeController = EdgeController(
      container: container,
      workflowId: 'workflow1',
      behavior: DefaultEdgeBehavior(),
    );

    const canvasConfig = CanvasVisualConfig(
      backgroundColor: Colors.white,
      showGrid: true,
      gridColor: Colors.grey,
      gridSpacing: 20,
    );

    return MaterialApp(
      // 你也可以加个 title, theme 等
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // 可选的 Scaffold，可根据需要包裹 AppBar
        body: GraphEditor(
          workflowId: 'workflow1', // 指定要使用的 workflow ID
          visualConfig: canvasConfig, // 画布的可视化配置
          initialOffset: Offset.zero, // 画布初始平移
          initialScale: 1.0, // 画布初始缩放

          nodeController: nodeController,
          edgeController: edgeController,
        ),
      ),
    );
  }
}
