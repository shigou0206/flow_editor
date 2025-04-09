// lib/providers.dart

import 'package:flutter/material.dart'; // 为了用 Offset
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';

/// 存储画布上的节点列表
final nodesProvider = StateProvider<List<NodeModel>>((ref) => [
      // 初始化放置 start/end 节点
      NodeModel(
        id: 'start',
        title: 'Start',
        type: NodeType.normal,
        x: 200,
        y: 100,
      ),
      NodeModel(
        id: 'end',
        title: 'End',
        type: NodeType.normal,
        x: 200,
        y: 300,
      ),

      NodeModel(
        id: 'node_1',
        title: 'Node 1',
        type: NodeType.normal,
        x: 200,
        y: 500,
      ),
      NodeModel(
        id: 'node_2',
        title: 'Node 2',
        type: NodeType.normal,
        x: 200,
        y: 700,
      ),
      NodeModel(
        id: 'node_3',
        title: 'Node 3',
        type: NodeType.normal,
        x: 200,
        y: 900,
      ),
    ]);

/// 存储画布上的边列表
final edgesProvider = StateProvider<List<EdgeModel>>((ref) => [
      EdgeModel(
        id: 'edge_start_node_1',
        sourceId: 'start',
        targetId: 'node_1',
      ),
      EdgeModel(
        id: 'edge_start_node_2',
        sourceId: 'start',
        targetId: 'node_2',
      ),
      EdgeModel(
        id: 'edge_node_1_node_3',
        sourceId: 'node_1',
        targetId: 'node_3',
      ),
      EdgeModel(
        id: 'edge_node_2_node_3',
        sourceId: 'node_2',
        targetId: 'node_3',
      ),
      EdgeModel(
        id: 'edge_node_3_end',
        sourceId: 'node_3',
        targetId: 'end',
      ),
    ]);

/// 用于生成新节点ID的计数器
final nodeCounterProvider = StateProvider<int>((ref) => 1);

/// 存储每条边的路由折线（由 DAGRE 计算出的 points）
final edgeRoutesProvider =
    StateProvider<Map<String, List<Offset>>>((ref) => {});
