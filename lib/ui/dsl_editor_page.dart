// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:flow_editor/core/models/edge_model.dart';
// import 'package:flow_editor/core/state_management/providers.dart';
// import 'package:flow_editor/ui/canvas/sfn/sfn_editor_canvas.dart';
// import 'package:flow_editor/ui/sidebar/sfn/nodes_sidebar.dart';
// import 'package:flow_editor/core/state_management/theme_provider.dart';
// import 'package:flow_editor/layout/sugiyama_layout.dart';

// // 新增：DSL转换工具
// import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
// import 'package:flow_editor/workflow/converters/dsl_graph_converter.dart';

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
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initAndLayoutNodesFromDsl();
//     });
//   }

//   void _initAndLayoutNodesFromDsl() {
//     final canvasContext = canvasKey.currentContext;
//     if (canvasContext == null) return;

//     final RenderBox canvasBox = canvasContext.findRenderObject() as RenderBox;
//     final Size canvasSize = canvasBox.size;

//     if (canvasSize == Size.zero) {
//       WidgetsBinding.instance
//           .addPostFrameCallback((_) => _initAndLayoutNodesFromDsl());
//       return;
//     }

//     // 🚩 写死的DSL数据（后续替换为API调用）
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
//                 'value': 90
//               },
//               'next': 'HighScore'
//             }
//           ],
//           'defaultNext': 'LowScore'
//         },
//         'HighScore': {'type': 'Succeed'},
//         'LowScore': {'type': 'Fail'}
//       }
//     });

//     final graphData = DslGraphConverter.toGraph(workflowDsl);
//     final nodes = graphData['nodes'] as List<NodeModel>;
//     final edges = graphData['edges'] as List<EdgeModel>;

//     // 🚩 定义统一的Group节点
//     const groupId = 'group_root';
//     const groupNode = NodeModel(
//       id: groupId,
//       type: 'middle',
//       title: 'Workflow Group',
//       position: Offset(100, 100),
//       size: Size.zero,
//       isGroup: true,
//     );

//     // 🚩 新增视觉起始节点（start）和结束节点（end）
//     const visualStartNode = NodeModel(
//       id: '__visual_start__',
//       type: 'start',
//       title: 'Start',
//       position: Offset.zero,
//       size: Size(30, 30),
//       parentId: groupId,
//     );

//     const visualEndNode = NodeModel(
//       id: '__visual_end__',
//       type: 'end',
//       title: 'End',
//       position: Offset.zero,
//       size: Size(30, 30),
//       parentId: groupId,
//     );

//     // 🚩 将所有现有节点的parentId设置为统一的group节点
//     final groupedNodes =
//         nodes.map((node) => node.copyWith(parentId: groupId)).toList();

//     // 🚩 加入group节点、visualStart和visualEnd节点
//     groupedNodes.insert(0, groupNode);
//     groupedNodes.addAll([visualStartNode, visualEndNode]);

//     // 🚩 新增visualStart到startAt节点的边
//     edges.add(EdgeModel.generated(
//       sourceNodeId: visualStartNode.id,
//       targetNodeId: workflowDsl.startAt,
//     ));

//     // 🚩 所有end节点(Succeed, Fail)指向visualEnd节点
//     final endNodeTypes = {'Succeed', 'Fail'};
//     final endNodes =
//         groupedNodes.where((node) => endNodeTypes.contains(node.type));
//     for (final endNode in endNodes) {
//       edges.add(EdgeModel.generated(
//         sourceNodeId: endNode.id,
//         targetNodeId: visualEndNode.id,
//       ));
//     }

//     // ✅ 调用自动布局算法（Sugiyama算法）
//     final layout = SugiyamaLayoutStrategy();
//     layout.performLayout(groupedNodes, edges);

//     final editorNotifier = ref.read(activeEditorNotifierProvider);
//     final currentState = ref.read(activeEditorStateProvider);

//     editorNotifier.replaceState(
//       currentState.copyWith(
//         nodeState: currentState.nodeState.copyWith(nodes: groupedNodes),
//         edgeState: currentState.edgeState.copyWith(edges: edges),
//       ),
//     );
//   }

//   // void _initAndLayoutNodesFromDsl() {
//   //   final canvasContext = canvasKey.currentContext;
//   //   if (canvasContext == null) return;

//   //   final RenderBox canvasBox = canvasContext.findRenderObject() as RenderBox;
//   //   final Size canvasSize = canvasBox.size;

//   //   if (canvasSize == Size.zero) {
//   //     WidgetsBinding.instance
//   //         .addPostFrameCallback((_) => _initAndLayoutNodesFromDsl());
//   //     return;
//   //   }

//   //   // 🚩 写死的DSL数据（后续替换为API调用）
//   //   final workflowDsl = WorkflowDSL.fromJson({
//   //     'startAt': 'EvaluateScore',
//   //     'states': {
//   //       'EvaluateScore': {
//   //         'type': 'Choice',
//   //         'choices': [
//   //           {
//   //             'condition': {
//   //               'variable': '\$.score',
//   //               'operator': 'GreaterThan',
//   //               'value': 90
//   //             },
//   //             'next': 'HighScore'
//   //           }
//   //         ],
//   //         'defaultNext': 'LowScore'
//   //       },
//   //       'HighScore': {'type': 'Succeed'},
//   //       'LowScore': {'type': 'Fail'}
//   //     }
//   //   });

//   //   final graphData = DslGraphConverter.toGraph(workflowDsl);
//   //   final nodes = graphData['nodes'] as List<NodeModel>;
//   //   final edges = graphData['edges'] as List<EdgeModel>;

//   //   // 🚩 新增：统一的Group节点
//   //   const groupId = 'group_root';
//   //   const groupNode = NodeModel(
//   //     id: groupId,
//   //     type: 'middle',
//   //     title: 'Workflow Group',
//   //     position: Offset(100, 100), // Group的初始位置可自定义
//   //     size: Size.zero,
//   //     isGroup: true,
//   //   );

//   //   // 🚩 将所有节点的parentId设置为统一的group节点
//   //   final groupedNodes =
//   //       nodes.map((node) => node.copyWith(parentId: groupId)).toList();

//   //   // 🚩 加入group节点
//   //   groupedNodes.insert(0, groupNode);

//   //   // ✅ 调用自动布局算法（Sugiyama算法）
//   //   final layout = SugiyamaLayoutStrategy();
//   //   layout.performLayout(groupedNodes, edges);

//   //   final editorNotifier = ref.read(activeEditorNotifierProvider);
//   //   final currentState = ref.read(activeEditorStateProvider);

//   //   editorNotifier.replaceState(
//   //     currentState.copyWith(
//   //       nodeState: currentState.nodeState.copyWith(nodes: groupedNodes),
//   //       edgeState: currentState.edgeState.copyWith(edges: edges),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flow Editor (DSL Initialized)'),
//         actions: [
//           IconButton(
//             icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
//             onPressed: () {
//               ref.read(themeModeProvider.notifier).state =
//                   isDark ? ThemeMode.light : ThemeMode.dark;
//             },
//           ),
//         ],
//       ),
//       body: Row(
//         children: [
//           const FlowNodeSidebar(),
//           Expanded(
//             child: Container(
//               key: canvasKey,
//               child: const SfnEditorCanvas(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/ui/canvas/sfn_editor_canvas.dart';
import 'package:flow_editor/ui/sidebar/nodes_sidebar.dart';
import 'package:flow_editor/core/state_management/theme_provider.dart';
import 'package:flow_editor/layout/sugiyama_layout.dart';
import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/workflow/converters/dsl_graph_converter.dart';

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
    final canvasContext = canvasKey.currentContext;
    if (canvasContext == null) return;

    final canvasBox = canvasContext.findRenderObject() as RenderBox;
    if (canvasBox.size == Size.zero) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _initAndLayoutNodes());
      return;
    }

    // 🚩 写死的DSL数据 (替换为API调用即可)
    final workflowDsl = WorkflowDSL.fromJson({
      'startAt': 'EvaluateScore',
      'states': {
        'EvaluateScore': {
          'type': 'Choice',
          'choices': [
            {
              'condition': {
                'variable': '\$.score',
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

    // 🚩 已自动处理 group/start/end 节点和连接
    final graphData = DslGraphConverter.toGraph(workflowDsl);
    final nodes = graphData['nodes'] as List<NodeModel>;
    final edges = graphData['edges'] as List<EdgeModel>;

    // ✅ 自动布局
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow Editor (DSL Initialized)'),
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
          const FlowNodeSidebar(),
          Expanded(
            child: Container(
              key: canvasKey,
              child: const SfnEditorCanvas(),
            ),
          ),
        ],
      ),
    );
  }
}
