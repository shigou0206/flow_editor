import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/layout/sugiyama_layout.dart';

class DslEditorWidget extends ConsumerStatefulWidget {
  const DslEditorWidget({super.key});

  @override
  ConsumerState<DslEditorWidget> createState() => _DslEditorWidgetState();
}

class _DslEditorWidgetState extends ConsumerState<DslEditorWidget> {
  final controller = TextEditingController();

  void loadDsl() {
    final editorState = ref.read(activeEditorStateProvider);
    final data = {
      "nodes": editorState.nodeState.nodes.map((n) => n.toJson()).toList(),
      "edges": editorState.edgeState.edges.map((e) => e.toJson()).toList(),
    };
    controller.text = const JsonEncoder.withIndent('  ').convert(data);
  }

  void updateCanvas() {
    try {
      final jsonData = jsonDecode(controller.text);
      final nodes = (jsonData['nodes'] as List)
          .map((e) => NodeModel.fromJson(e))
          .toList();
      final edges = (jsonData['edges'] as List)
          .map((e) => EdgeModel.fromJson(e))
          .toList();

      final editorNotifier = ref.read(activeEditorNotifierProvider);
      final currentState = ref.read(activeEditorStateProvider);

      editorNotifier.replaceState(
        currentState.copyWith(
          nodeState: currentState.nodeState.copyWith(nodes: nodes),
          edgeState: currentState.edgeState.copyWith(edges: edges),
        ),
      );

      SugiyamaLayoutStrategy().performLayout(nodes, edges);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('画布已更新'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('解析出错: $e'),
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
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: updateCanvas,
              child: const Text("更新画布"),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: loadDsl,
              child: const Text("刷新"),
            ),
          ],
        ),
      ],
    );
  }
}
