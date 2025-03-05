import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 请根据你的项目结构调整导入路径
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
    final workflowId = 'default';

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

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MaterialApp(home: MyCanvasPage()));
// }

// /// 数据模型
// class NodeModel {
//   final String id;
//   double x;
//   double y;
//   final double width;
//   final double height;

//   NodeModel({
//     required this.id,
//     required this.x,
//     required this.y,
//     this.width = 80,
//     this.height = 40,
//   });
// }

// /// 页面示例
// class MyCanvasPage extends StatefulWidget {
//   const MyCanvasPage({Key? key}) : super(key: key);

//   @override
//   State<MyCanvasPage> createState() => _MyCanvasPageState();
// }

// class _MyCanvasPageState extends State<MyCanvasPage> {
//   // 模拟“模式”：editNode or panCanvas
//   bool isEditNodeMode = true;

//   // 画布的平移和缩放
//   Offset _offset = const Offset(0, 0);
//   double _scale = 1.0;

//   // 节点数组
//   final List<NodeModel> _nodes = [
//     NodeModel(id: 'A', x: 100, y: 100),
//     NodeModel(id: 'B', x: 200, y: 200),
//   ];

//   // 拖拽状态
//   bool _isDraggingNode = false;
//   NodeModel? _draggingNode;

//   // 用于获取 Stack 的 RenderBox
//   final GlobalKey _stackKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Demo: Stack + Transform 拖拽节点 (mode=${isEditNodeMode ? 'editNode' : 'panCanvas'})'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.swap_horiz),
//             onPressed: () {
//               setState(() {
//                 // 切换模式
//                 isEditNodeMode = !isEditNodeMode;
//               });
//             },
//           ),
//         ],
//       ),
//       body: Listener(
//         onPointerDown: (event) => _startDrag(event.position),
//         onPointerMove: (event) => _updateDrag(event.delta),
//         onPointerUp: (event) => _endDrag(),
//         child: Stack(
//           children: [
//             // 1) 画布(Transform+Stack)
//             Transform(
//               transform: Matrix4.identity()
//                 ..translate(_offset.dx, _offset.dy)
//                 ..scale(_scale),
//               child: Stack(
//                 key: _stackKey,
//                 children: [
//                   for (final node in _nodes)
//                     Positioned(
//                       left: node.x,
//                       top: node.y,
//                       child: Container(
//                         width: node.width,
//                         height: node.height,
//                         color: Colors.blue,
//                         alignment: Alignment.center,
//                         child: Text(node.id, style: const TextStyle(color: Colors.white)),
//                       ),
//                     )
//                 ],
//               ),
//             ),

//             // 2) 底部显示坐标信息
//             Positioned(
//               left: 10,
//               bottom: 10,
//               child: Text('Offset=$_offset, scale=$_scale'),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {
//           setState(() {
//             // 添加个节点
//             final node = NodeModel(
//               id: 'N${DateTime.now().millisecondsSinceEpoch}',
//               x: 150,
//               y: 150,
//             );
//             _nodes.add(node);
//           });
//         },
//       ),
//     );
//   }

//   // ===================== 画布交互 =====================

//   void _startDrag(Offset globalPos) {
//     if (!isEditNodeMode) {
//       // 如果是 panCanvas 模式，直接不判定节点
//       // 也可以这样写: 全部都命中测试，然后没点到再拖画布
//       setState(() {
//         _isDraggingNode = false;
//         _draggingNode = null;
//       });
//       return;
//     }

//     // 如果是 editNode 模式 => 命中测试节点
//     final canvasPt = _globalToCanvas(globalPos);
//     final hit = _hitTestNode(canvasPt);
//     setState(() {
//       if (hit != null) {
//         _isDraggingNode = true;
//         _draggingNode = hit;
//       } else {
//         _isDraggingNode = false;
//         _draggingNode = null;
//       }
//     });
//   }

//   void _updateDrag(Offset delta) {
//     setState(() {
//       if (_isDraggingNode && _draggingNode != null) {
//         // 拖拽节点
//         _draggingNode!.x += delta.dx / _scale;
//         _draggingNode!.y += delta.dy / _scale;
//       } else {
//         // 拖动画布
//         _offset += delta;
//       }
//     });
//   }

//   void _endDrag() {
//     setState(() {
//       _isDraggingNode = false;
//       _draggingNode = null;
//     });
//   }

//   // ===================== 命中检测 =====================

//   NodeModel? _hitTestNode(Offset canvasPt) {
//     // 倒序保证后画的节点优先命中
//     for (final node in _nodes.reversed) {
//       final rect = Rect.fromLTWH(node.x, node.y, node.width, node.height);
//       if (rect.contains(canvasPt)) {
//         return node;
//       }
//     }
//     return null;
//   }

//   // ===================== 坐标转换 =====================
//   // 先把 globalPos 转到 stack 的本地坐标 localPos
//   // 再减 offset, 再除 scale => 得到 "画布坐标"
//   Offset _globalToCanvas(Offset globalPos) {
//     final renderObject = _stackKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderObject == null) return Offset.zero;

//     final localPos = renderObject.globalToLocal(globalPos);
//     return (localPos - _offset) / _scale;
//   }
// }