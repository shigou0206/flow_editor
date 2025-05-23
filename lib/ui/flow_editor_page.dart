import 'package:flutter/material.dart';
import 'package:flow_editor/ui/sidebar/flow_node_sidebar.dart';
import 'package:flow_editor/ui/canvas/flow_editor_canvas.dart';

class FlowEditorPage extends StatelessWidget {
  const FlowEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          FlowNodeSidebar(
            onNodeTemplateDragged: (_) {}, // 如有后续处理逻辑可扩展
          ),
          const Expanded(child: FlowEditorCanvas()),
        ],
      ),
    );
  }
}
