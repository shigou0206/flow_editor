// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flow_editor/core/state_management/providers.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:flow_editor/core/models/edge_model.dart';
// import 'package:flow_editor/layout/sugiyama_layout.dart';

// class DslEditorWidget extends ConsumerStatefulWidget {
//   const DslEditorWidget({super.key});

//   @override
//   ConsumerState<DslEditorWidget> createState() => _DslEditorWidgetState();
// }

// class _DslEditorWidgetState extends ConsumerState<DslEditorWidget> {
//   final TextEditingController controller = TextEditingController();

//   void loadDsl() {
//     final editorState = ref.read(activeEditorStateProvider);
//     final data = {
//       "nodes": editorState.nodeState.nodes.map((n) => n.toJson()).toList(),
//       "edges": editorState.edgeState.edges.map((e) => e.toJson()).toList(),
//     };
//     controller.text = const JsonEncoder.withIndent('  ').convert(data);
//   }

//   void updateCanvas() {
//     try {
//       final jsonData = jsonDecode(controller.text);
//       final nodes = (jsonData['nodes'] as List)
//           .map((e) => NodeModel.fromJson(e))
//           .toList();
//       final edges = (jsonData['edges'] as List)
//           .map((e) => EdgeModel.fromJson(e))
//           .toList();

//       SugiyamaLayoutStrategy().performLayout(nodes, edges);

//       final editorNotifier = ref.read(activeEditorNotifierProvider);
//       final currentState = ref.read(activeEditorStateProvider);

//       editorNotifier.replaceState(
//         currentState.copyWith(
//           nodeState: currentState.nodeState.copyWith(nodes: nodes),
//           edgeState: currentState.edgeState.copyWith(edges: edges),
//         ),
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('画布已成功更新 🎉')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('解析DSL失败 ⚠️: $e')),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => loadDsl());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Expanded(
//           child: TextField(
//             controller: controller,
//             maxLines: null,
//             expands: true,
//             keyboardType: TextInputType.multiline,
//             textAlignVertical: TextAlignVertical.top,
//             style: const TextStyle(
//               fontFamily: 'RobotoMono',
//               fontSize: 13,
//               height: 1.4,
//             ),
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               contentPadding: const EdgeInsets.all(12),
//               hintText: '请输入DSL JSON...',
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ElevatedButton.icon(
//               onPressed: loadDsl,
//               icon: const Icon(Icons.refresh),
//               label: const Text("刷新"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.grey.shade200,
//               ),
//             ),
//             const SizedBox(width: 12),
//             ElevatedButton.icon(
//               onPressed: updateCanvas,
//               icon: const Icon(Icons.check_circle_outline),
//               label: const Text("更新画布"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).colorScheme.primary,
//                 foregroundColor: Theme.of(context).colorScheme.onPrimary,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/layout/sugiyama_layout.dart';
import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/workflow/converters/graph_dsl_converter.dart';
import 'package:flow_editor/workflow/converters/dsl_graph_converter.dart';

class DslEditorWidget extends ConsumerStatefulWidget {
  const DslEditorWidget({super.key});

  @override
  ConsumerState<DslEditorWidget> createState() => _DslEditorWidgetState();
}

class _DslEditorWidgetState extends ConsumerState<DslEditorWidget> {
  final controller = TextEditingController();

  void loadDsl() {
    final editorState = ref.read(activeEditorStateProvider);
    final nodes = editorState.nodeState.nodes;
    final edges = editorState.edgeState.edges;

    final workflowDsl = GraphDslConverter.toDsl(
      nodes: nodes,
      edges: edges,
      startAt: 'start_node', // 此处根据你的需求动态确定
    );

    controller.text =
        const JsonEncoder.withIndent('  ').convert(workflowDsl.toJson());
  }

  void updateCanvas() {
    try {
      final jsonData = jsonDecode(controller.text);
      final workflowDsl = WorkflowDSL.fromJson(jsonData);

      final graphData = DslGraphConverter.toGraph(workflowDsl);
      final nodes = graphData['nodes'] as List<NodeModel>;
      final edges = graphData['edges'] as List<EdgeModel>;

      SugiyamaLayoutStrategy().performLayout(nodes, edges);

      final editorNotifier = ref.read(activeEditorNotifierProvider);
      final currentState = ref.read(activeEditorStateProvider);

      editorNotifier.replaceState(
        currentState.copyWith(
          nodeState: currentState.nodeState.copyWith(nodes: nodes),
          edgeState: currentState.edgeState.copyWith(edges: edges),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('🎉 画布已根据DSL更新'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('⚠️ 解析出错: $e'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    loadDsl();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: true,
            style: const TextStyle(fontFamily: 'Roboto Mono'),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Workflow DSL JSON',
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: updateCanvas,
              icon: const Icon(Icons.refresh),
              label: const Text("更新画布"),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: loadDsl,
              icon: const Icon(Icons.download),
              label: const Text("刷新DSL"),
            ),
          ],
        ),
      ],
    );
  }
}
