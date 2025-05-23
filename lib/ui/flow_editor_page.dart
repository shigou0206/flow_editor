// flow_editor_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/ui/canvas/flow_editor_canvas.dart';
import 'package:flow_editor/ui/sidebar/flow_node_sidebar.dart';
import 'package:flow_editor/core/state_management/theme_provider.dart';

class FlowEditorPage extends ConsumerWidget {
  const FlowEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow Editor'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              ref.read(themeModeProvider.notifier).state =
                  isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: Row(
        children: [
          FlowNodeSidebar(onNodeTemplateDragged: (node) {
            // 你的处理逻辑
          }),
          const Expanded(child: FlowEditorCanvas()),
        ],
      ),
    );
  }
}
