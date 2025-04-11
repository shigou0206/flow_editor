import 'package:flutter/material.dart'; // 为了使用 Offset
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';

/// 存储画布上的节点列表
final nodesProvider = StateProvider<List<NodeModel>>((ref) => [
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
    ]);

/// 存储画布上的边列表
final edgesProvider = StateProvider<List<EdgeModel>>((ref) => [
      EdgeModel(
        id: 'edge_start_end',
        sourceId: 'start',
        targetId: 'end',
      ),
    ]);

/// 用于生成新节点 ID 的计数器
final nodeCounterProvider = StateProvider<int>((ref) => 1);

/// 存储每条边的路由折线（由 dagre 计算出的 points）
final edgeRoutesProvider =
    StateProvider<Map<String, List<Offset>>>((ref) => {});
