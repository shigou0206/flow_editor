// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flow_editor/core/state_management/providers.dart';
// import 'package:flow_editor/core/state_management/theme_provider.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:flow_editor/core/models/edge_model.dart';
// import 'package:flow_editor/layout/sugiyama_layout.dart';
// import 'package:flow_editor/ui/canvas/sfn_editor_canvas.dart';
// import 'package:flow_editor/ui/sidebar/nodes_sidebar.dart';
// import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
// import 'package:flow_editor/workflow/converters/dsl_graph_converter.dart';
// import 'package:flow_editor/ui/property_editor/node_property_editor.dart';

// final selectedNodeIdProvider = StateProvider<String?>((_) => null);

// class DslEditorPage extends ConsumerStatefulWidget {
//   const DslEditorPage({super.key});

//   @override
//   ConsumerState<DslEditorPage> createState() => _DslEditorPageState();
// }

// class _DslEditorPageState extends ConsumerState<DslEditorPage> {
//   final GlobalKey canvasKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => _initAndLayoutNodes());
//   }

//   void _initAndLayoutNodes() {
//     final canvasContext = canvasKey.currentContext;
//     if (canvasContext == null) return;

//     final canvasBox = canvasContext.findRenderObject() as RenderBox;
//     if (canvasBox.size == Size.zero) {
//       WidgetsBinding.instance
//           .addPostFrameCallback((_) => _initAndLayoutNodes());
//       return;
//     }

//     final workflowDsl = WorkflowDSL.fromJson({
//       'startAt': 'EvaluateScore',
//       'states': {
//         'EvaluateScore': {
//           'type': 'Choice',
//           'choices': [
//             {
//               'condition': {
//                 'variable': '\$.score',
//                 'operator': 'GreaterThan',
//                 'value': 90,
//               },
//               'next': 'HighScore',
//             },
//           ],
//           'defaultNext': 'LowScore',
//         },
//         'HighScore': {'type': 'Succeed', 'end': true},
//         'LowScore': {'type': 'Fail', 'end': true},
//       },
//     });

//     final graphData = DslGraphConverter.toGraph(workflowDsl);
//     final nodes = graphData['nodes'] as List<NodeModel>;
//     final edges = graphData['edges'] as List<EdgeModel>;

//     SugiyamaLayoutStrategy().performLayout(nodes, edges);

//     final editorNotifier = ref.read(activeEditorNotifierProvider);
//     final currentState = ref.read(activeEditorStateProvider);

//     editorNotifier.replaceState(
//       currentState.copyWith(
//         nodeState: currentState.nodeState.copyWith(nodes: nodes),
//         edgeState: currentState.edgeState.copyWith(edges: edges),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
//     final dividerColor = Theme.of(context).dividerColor;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flow Editor (DSL Initialized)'),
//         actions: [
//           IconButton(
//             icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
//             onPressed: () => ref.read(themeModeProvider.notifier).state =
//                 isDark ? ThemeMode.light : ThemeMode.dark,
//           ),
//         ],
//       ),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             width: 220,
//             color: Theme.of(context).colorScheme.surfaceVariant,
//             child: const FlowNodeSidebar(),
//           ),
//           Expanded(
//             child: ClipRect(
//               child: Container(
//                 key: canvasKey,
//                 color: Theme.of(context).canvasColor,
//                 child: const SfnEditorCanvas(),
//               ),
//             ),
//           ),
//           Container(
//             width: 300,
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.surfaceVariant,
//               border: Border(
//                 left: BorderSide(width: 1, color: dividerColor),
//               ),
//             ),
//             child: const NodePropertyEditor(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/state_management/theme_provider.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/layout/sugiyama_layout.dart';
import 'package:flow_editor/ui/canvas/sfn_editor_canvas.dart';
import 'package:flow_editor/ui/sidebar/nodes_sidebar.dart';
import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/workflow/converters/dsl_graph_converter.dart';
import 'package:flow_editor/ui/property_editor/node_property_editor.dart';

final selectedNodeIdProvider = StateProvider<String?>((_) => null);

class DslEditorPage extends ConsumerStatefulWidget {
  const DslEditorPage({super.key});

  @override
  ConsumerState<DslEditorPage> createState() => _DslEditorPageState();
}

class _DslEditorPageState extends ConsumerState<DslEditorPage> {
  final GlobalKey canvasKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initAndLayoutNodes());
  }

  void _initAndLayoutNodes() {
    final workflowDsl = WorkflowDSL.fromJson({
      'startAt': 'EvaluateScore',
      'states': {
        'EvaluateScore': {
          'type': 'Choice',
          'choices': [
            {
              'condition': {
                'variable': r'$.score',
                'operator': 'GreaterThan',
                'value': 90,
              },
              'next': 'HighScore',
            },
          ],
          'defaultNext': 'LowScore',
        },
        'HighScore': {'type': 'Succeed', 'end': true},
        'LowScore': {'type': 'Fail', 'end': true},
      },
    });

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
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    final canvasState = ref.watch(activeEditorStateProvider).canvasState;
    final canvasController = ref.read(activeCanvasControllerProvider);

    void handleZoom(double newScale) {
      final canvasBox =
          canvasKey.currentContext?.findRenderObject() as RenderBox?;
      final focalPoint =
          canvasBox != null ? canvasBox.size.center(Offset.zero) : Offset.zero;
      canvasController.viewport
          .zoomAt(focalPoint, newScale / canvasState.scale);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow Editor'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => ref.read(themeModeProvider.notifier).state =
                isDark ? ThemeMode.light : ThemeMode.dark,
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 220,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const FlowNodeSidebar(),
          ),
          Expanded(
            child: Stack(
              children: [
                ClipRect(
                  child: Container(
                    key: canvasKey,
                    color: Theme.of(context).canvasColor,
                    child: const SfnEditorCanvas(),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            final newScale =
                                (canvasState.scale - 0.1).clamp(0.5, 2.0);
                            handleZoom(newScale);
                          },
                        ),
                        SizedBox(
                          width: 120,
                          child: Slider(
                            value: canvasState.scale,
                            min: 0.5,
                            max: 2.0,
                            onChanged: (newScale) => handleZoom(newScale),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final newScale =
                                (canvasState.scale + 0.1).clamp(0.5, 2.0);
                            handleZoom(newScale);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 300,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const NodePropertyEditor(),
          ),
        ],
      ),
    );
  }
}
