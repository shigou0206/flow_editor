import 'package:flutter/material.dart';

// ---------------------------
// 请确保以下 import 对应您贴出的路径/文件
// ---------------------------
import 'core/node/models/node_model.dart';
import 'core/anchor/models/anchor_model.dart';
import 'core/edge/models/edge_model.dart';
import 'core/edge/models/edge_line_style.dart';
import 'core/anchor/models/anchor_enums.dart';
import 'core/types/position_enum.dart';

import 'core/node/behaviors/node_behavior.dart';
import 'core/state_management/node_state/node_state.dart';

import 'core/canvas/renderers/canvas_renderer.dart';
import 'core/canvas/models/canvas_visual_config.dart';
import 'core/state_management/edge_state/edge_state.dart';

void main() => runApp(const MyApp());

/// 1. 根部件
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GraphTestPage(),
      ),
    );
  }
}

/// 2. 测试页面
class GraphTestPage extends StatelessWidget {
  const GraphTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1) 构造 NodeState: 两个节点
    final nodeState = _buildTestNodeState();

    // 2) 构造 EdgeState: 用一条线连接它们
    final edgeState = _buildTestEdgeState();

    // 3) 画布视觉配置
    final canvasVisualConfig = CanvasVisualConfig(
      backgroundColor: Colors.white,
      showGrid: true,
      gridColor: Colors.grey[300]!,
      gridSpacing: 20,
    );

    // 4) NodeBehavior
    final nodeBehavior = _TestNodeBehavior();

    // 5) 组合成 CanvasRenderer
    return CanvasRenderer(
      nodeState: nodeState,
      edgeState: edgeState,
      canvasVisualConfig: canvasVisualConfig,
      nodeBehavior: nodeBehavior,
      canvasOffset: const Offset(0, 0),
      canvasScale: 1.0,
    );
  }

  /// 构建一个简单的 NodeState
  NodeState _buildTestNodeState() {
    final nodeMap = <String, NodeModel>{};

    // Node A (只有一个右侧锚点 => 输出)
    final nodeA = NodeModel(
      id: 'nodeA',
      x: 100,
      y: 120,
      width: 120,
      height: 60,
      title: 'Node A',
      anchors: [
        AnchorModel(
          id: 'anchor_out', // 用于输出
          nodeId: 'nodeA',
          position: Position.right,
          placement: AnchorPlacement.outside,
          offsetDistance: 10,
        ),
      ],
    );

    // Node B (只有一个左侧锚点 => 输入)
    final nodeB = NodeModel(
      id: 'nodeB',
      x: 300, // 与 nodeA 水平对齐
      y: 120,
      width: 120,
      height: 60,
      title: 'Node B',
      anchors: [
        AnchorModel(
          id: 'anchor_in', // 用于输入
          nodeId: 'nodeB',
          position: Position.left,
          placement: AnchorPlacement.inside,
          offsetDistance: 10,
        ),
      ],
    );

    nodeMap[nodeA.id] = nodeA;
    nodeMap[nodeB.id] = nodeB;

    return NodeState(
      nodesByWorkflow: {
        'workflow1': nodeMap,
      },
    );
  }

  /// 构建一个简单的 EdgeState
  EdgeState _buildTestEdgeState() {
    final edgeMap = <String, EdgeModel>{};

    // 让 NodeA(anchor_out) -> NodeB(anchor_in)
    final edgeAB = EdgeModel(
      id: 'edgeAB',
      sourceNodeId: 'nodeA',
      sourceAnchorId: 'anchor_out',
      targetNodeId: 'nodeB',
      targetAnchorId: 'anchor_in',

      // 必须设 isConnected = true 才会完整绘制
      isConnected: true,

      // 使用红色, 且 strokeWidth = 4
      lineStyle: EdgeLineStyle(
        colorHex: '#FF0000',
        strokeWidth: 4,
      ),
    );

    edgeMap[edgeAB.id] = edgeAB;

    return EdgeState(
      edgesByWorkflow: {
        'workflow1': edgeMap,
      },
    );
  }
}

/// 3. 一个简单 NodeBehavior
class _TestNodeBehavior extends NodeBehavior {
  @override
  void onTap(NodeModel node) {
    debugPrint('Node ${node.id} tapped');
  }

  @override
  void onDoubleTap(NodeModel node) {
    debugPrint('Node ${node.id} double-tapped');
  }

  @override
  void onContextMenu(NodeModel node, Offset localPos) {
    debugPrint('Node ${node.id} context menu at $localPos');
  }

  @override
  void onDelete(NodeModel node) {
    debugPrint('Node ${node.id} deleted');
  }

  @override
  void onHover(NodeModel node, bool hovering) {
    debugPrint('Node ${node.id} hover: $hovering');
  }
}
