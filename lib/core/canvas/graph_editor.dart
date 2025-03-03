// lib/graph_editor.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/canvas/controllers/canvas_controller.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/behaviors/default_node_behavior.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/state_management/node_state/node_state.dart';
import 'package:flow_editor/core/state_management/edge_state/edge_state.dart';
import 'package:flow_editor/core/anchor/behaviors/default_anchor_behavior.dart';
import 'package:flow_editor/core/canvas/controllers/canvas_mode_controller.dart';
import 'package:flow_editor/core/canvas/controllers/canvas_viewport_controller.dart';

class GraphEditor extends ConsumerStatefulWidget {
  const GraphEditor({Key? key}) : super(key: key);

  @override
  ConsumerState<GraphEditor> createState() => _GraphEditorState();
}

class _GraphEditorState extends ConsumerState<GraphEditor> {
  // --- Node/Edge State (world coordinates) ---
  late NodeState _nodeState;
  late EdgeState _edgeState;

  // --- Canvas Transformation Parameters ---
  Offset _canvasOffset = Offset.zero;
  double _canvasScale = 1.0;

  // --- Variables for node dragging (screen coordinates) ---
  String? _draggingNodeId;
  Offset? _lastPointerPos;

  // --- Default behaviors ---
  final _nodeBehavior = DefaultNodeBehavior();
  late DefaultAnchorBehavior _anchorBehavior;

  // --- Canvas Visual Configuration ---
  final CanvasVisualConfig _visualConfig = const CanvasVisualConfig(
    backgroundColor: Colors.white,
    showGrid: true,
    gridColor: Colors.grey,
    gridSpacing: 20,
  );

  @override
  void initState() {
    super.initState();
    _nodeState = _buildInitialNodeState();
    _edgeState = _buildInitialEdgeState();

    // 使用 ConsumerState 中的 ref 传递给 DefaultAnchorBehavior
    _anchorBehavior = DefaultAnchorBehavior(ref: ref, workflowId: 'workflow1');
  }

  NodeState _buildInitialNodeState() {
    // 创建两个示例节点，每个节点含有输入和输出锚点
    final nodeA = NodeModel(
      id: 'nodeA',
      x: 100,
      y: 120,
      width: 100,
      height: 60,
      title: 'Node A',
      anchors: [
        AnchorModel(
          id: 'outA',
          nodeId: 'nodeA',
          position: Position.right,
          placement: AnchorPlacement.outside,
          offsetDistance: 10,
          ratio: 0.5,
        ),
        AnchorModel(
          id: 'inA',
          nodeId: 'nodeA',
          position: Position.left,
          placement: AnchorPlacement.inside,
          offsetDistance: 10,
          ratio: 0.5,
        ),
      ],
    );

    final nodeB = NodeModel(
      id: 'nodeB',
      x: 300,
      y: 120,
      width: 100,
      height: 60,
      title: 'Node B',
      anchors: [
        AnchorModel(
          id: 'outB',
          nodeId: 'nodeB',
          position: Position.right,
          placement: AnchorPlacement.outside,
          offsetDistance: 10,
          ratio: 0.5,
        ),
        AnchorModel(
          id: 'inB',
          nodeId: 'nodeB',
          position: Position.left,
          placement: AnchorPlacement.inside,
          offsetDistance: 10,
          ratio: 0.5,
        ),
      ],
    );

    return NodeState(nodesByWorkflow: {
      'workflow1': {nodeA.id: nodeA, nodeB.id: nodeB},
    });
  }

  EdgeState _buildInitialEdgeState() {
    // 创建一个示例边，从 Node A 的输出连接到 Node B 的输入
    final edgeAB = EdgeModel(
      id: 'edgeAB',
      sourceNodeId: 'nodeA',
      sourceAnchorId: 'outA',
      targetNodeId: 'nodeB',
      targetAnchorId: 'inB',
      isConnected: true,
      lineStyle: const EdgeLineStyle(
        colorHex: '#FF0000',
        strokeWidth: 3,
        useBezier: false,
        arrowEnd: ArrowType.normal,
        arrowStart: ArrowType.none,
        dashPattern: [],
      ),
    );
    return EdgeState(edgesByWorkflow: {
      'workflow1': {edgeAB.id: edgeAB},
    });
  }

  /// 将屏幕坐标转换为世界坐标（用于拖拽时的命中检测）
  Offset screenToWorld(Offset screen) {
    return screen / _canvasScale + _canvasOffset;
  }

  // --- 节点拖拽逻辑 ---
  void _onPointerDown(PointerDownEvent event) {
    final worldPos = screenToWorld(event.localPosition);
    final node = _hitTestNode(worldPos);
    if (node != null) {
      _draggingNodeId = node.id;
      debugPrint('PointerDown: Node ${node.id} start drag');
    } else {
      _draggingNodeId = null;
    }
    _lastPointerPos = event.localPosition;
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_draggingNodeId != null && _lastPointerPos != null) {
      final deltaScreen = event.localPosition - _lastPointerPos!;
      final deltaWorld = deltaScreen / _canvasScale;
      _moveNode(_draggingNodeId!, deltaWorld);
    }
    _lastPointerPos = event.localPosition;
  }

  void _onPointerUp(PointerUpEvent event) {
    if (_draggingNodeId != null) {
      debugPrint('PointerUp: Node $_draggingNodeId end drag');
    }
    _draggingNodeId = null;
    _lastPointerPos = null;
  }

  void _moveNode(String nodeId, Offset deltaWorld) {
    final wf = _nodeState.nodesByWorkflow['workflow1'];
    if (wf == null) return;
    final node = wf[nodeId];
    if (node == null) return;
    wf[nodeId] = node.copyWith(
      x: node.x + deltaWorld.dx,
      y: node.y + deltaWorld.dy,
    );
    setState(() {
      _nodeState = _nodeState.copyWith(
        nodesByWorkflow: {..._nodeState.nodesByWorkflow, 'workflow1': wf},
      );
    });
  }

  NodeModel? _hitTestNode(Offset worldPos) {
    final wf = _nodeState.nodesByWorkflow['workflow1'];
    if (wf == null) return null;
    for (final node in wf.values) {
      final rect = Rect.fromLTWH(node.x, node.y, node.width, node.height);
      if (rect.contains(worldPos)) return node;
    }
    return null;
  }

  // --- 控制面板按钮处理 ---
  void _panRight() {
    setState(() {
      _canvasOffset += const Offset(10, 0);
    });
  }

  void _zoomIn() {
    setState(() {
      _canvasScale *= 1.1;
    });
  }

  void _zoomOut() {
    setState(() {
      _canvasScale /= 1.1;
    });
  }

  void _fitView() {
    final wf = _nodeState.nodesByWorkflow['workflow1'];
    if (wf == null || wf.isEmpty) return;
    double minX = double.infinity, minY = double.infinity;
    double maxX = -double.infinity, maxY = -double.infinity;
    for (final node in wf.values) {
      minX = min(minX, node.x);
      minY = min(minY, node.y);
      maxX = max(maxX, node.x + node.width);
      maxY = max(maxY, node.y + node.height);
    }
    final nodesWidth = maxX - minX;
    final nodesHeight = maxY - minY;
    const double margin = 20;
    final size = MediaQuery.of(context).size;
    final scaleX = (size.width - margin * 2) / nodesWidth;
    final scaleY = (size.height - margin * 2) / nodesHeight;
    final newScale = min(scaleX, scaleY);
    final centerX = (minX + maxX) / 2;
    final centerY = (minY + maxY) / 2;
    final offsetX = (size.width / newScale) / 2 - centerX;
    final offsetY = (size.height / newScale) / 2 - centerY;
    setState(() {
      _canvasScale = newScale;
      _canvasOffset = Offset(offsetX, offsetY);
    });
  }

  // --- 新增/删除节点 (测试用) ---
  int _newNodeCount = 0;
  void _addNewNode() {
    setState(() {
      final wf = _nodeState.nodesByWorkflow['workflow1']!;
      final newId = 'newNode_${DateTime.now().millisecondsSinceEpoch}';
      final newNode = NodeModel(
        id: newId,
        x: 200.0,
        y: 200.0,
        width: 80,
        height: 40,
        title: newId,
        anchors: [
          // 输出锚点：右侧（outside）
          AnchorModel(
            id: 'out_$newId',
            nodeId: newId,
            position: Position.right,
            placement: AnchorPlacement.outside,
            offsetDistance: 10,
            ratio: 0.5,
          ),
          // 输入锚点：左侧（inside）
          AnchorModel(
            id: 'in_$newId',
            nodeId: newId,
            position: Position.left,
            placement: AnchorPlacement.inside,
            offsetDistance: 10,
            ratio: 0.5,
          ),
        ],
      );
      wf[newId] = newNode;
      _nodeState = _nodeState.copyWith(
        nodesByWorkflow: {..._nodeState.nodesByWorkflow, 'workflow1': wf},
      );
      debugPrint('Added new Node $newId');
    });
  }

  void _removeLastNode() {
    setState(() {
      final wf = _nodeState.nodesByWorkflow['workflow1']!;
      if (wf.isEmpty) return;
      final lastKey = wf.keys.last;
      wf.remove(lastKey);
      _nodeState = _nodeState.copyWith(
        nodesByWorkflow: {..._nodeState.nodesByWorkflow, 'workflow1': wf},
      );
      debugPrint('Removed node $lastKey');
    });
  }

  @override
  Widget build(BuildContext context) {
    // 外层 Transform 将世界坐标转换为屏幕坐标
    return Stack(
      children: [
        Listener(
          onPointerDown: _onPointerDown,
          onPointerMove: _onPointerMove,
          onPointerUp: _onPointerUp,
          child: ClipRect(
            child: Transform(
              transform: Matrix4.identity()
                ..translate(-_canvasOffset.dx * _canvasScale,
                    -_canvasOffset.dy * _canvasScale)
                ..scale(_canvasScale),
              alignment: Alignment.topLeft,
              child: CanvasController(
                nodeState: _nodeState,
                edgeState: _edgeState,
                visualConfig: _visualConfig,
                nodeBehavior: _nodeBehavior,
                anchorBehavior:
                    DefaultAnchorBehavior(ref: ref, workflowId: 'workflow1'),
                offset: Offset.zero,
                scale: 1.0,
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: _addNewNode,
                child: const Text('Add Node'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _removeLastNode,
                child: const Text('Remove Last Node'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _panRight,
                child: const Text('Pan Right'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _zoomIn,
                child: const Text('Zoom In'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _zoomOut,
                child: const Text('Zoom Out'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _fitView,
                child: const Text('Fit View'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
