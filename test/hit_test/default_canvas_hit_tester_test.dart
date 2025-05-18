// test/hit_test/default_canvas_hit_tester_models_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';

import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/hit_test/default_canvas_hit_tester.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';
import 'package:flow_editor/core/models/styles/edge_line_style.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';

void main() {
  late CanvasHitTester tester;
  late NodeModel startNode, endNode;
  late EdgeModel edge;

  setUp(() {
    // 构造两个节点，分别有一个右侧锚点(in_anchor)和左侧锚点(out_anchor)
    startNode = NodeModel(
      id: 'start_node',
      position: const Offset(10, 10),
      size: const Size(100, 100),
      anchors: [
        AnchorModel(
          id: 'in_anchor',
          position: Position.right,
          size: const Size(10, 10),
          nodeId: 'start_node',
        ),
      ],
    );

    endNode = NodeModel(
      id: 'end_node',
      position: const Offset(10, 150),
      size: const Size(100, 100),
      anchors: [
        AnchorModel(
          id: 'out_anchor',
          position: Position.left,
          size: const Size(10, 10),
          nodeId: 'end_node',
        ),
      ],
    );

    edge = EdgeModel(
      id: 'edge1',
      sourceNodeId: 'start_node',
      sourceAnchorId: 'in_anchor',
      targetNodeId: 'end_node',
      targetAnchorId: 'out_anchor',
      lineStyle: const EdgeLineStyle(), // 默认样式
    );

    final nodes = [startNode, endNode];
    final edges = [edge];

    tester = DefaultCanvasHitTester(
      getNodes: () => nodes,
      getAnchors: () {
        // 扁平化所有节点的 anchors 列表
        return nodes.expand((n) => n.anchors ?? []).toList()
            as List<AnchorModel>;
      },
      getEdges: () => edges,
      // 使用项目中的计算方法
      computeAnchorWorldPosition: (node, anchor, allNodes) {
        return computeAnchorWorldPosition(node, anchor, allNodes);
      },
      anchorThreshold: 5.0,
    );
  });

  group('Model-based DefaultCanvasHitTester', () {
    test('hitTestNode detects each node by its bounds', () {
      // 直接在 startNode 区域
      expect(tester.hitTestNode(const Offset(20, 20)), 'start_node');
      // 在 endNode 区域
      expect(tester.hitTestNode(const Offset(20, 160)), 'end_node');
      // 完全不在任何节点内
      expect(tester.hitTestNode(const Offset(500, 500)), isNull);
    });

    test('hitTestAnchor detects anchors at correct world positions', () {
      // 计算 in_anchor 世界中心：
      final inCenter = computeAnchorWorldPosition(
        startNode,
        startNode.anchors!.first,
        [startNode, endNode],
      );
      // 稍微偏移，但在 threshold 范围内
      expect(tester.hitTestAnchor(inCenter + const Offset(3, 0)), 'in_anchor');

      // out_anchor 同理
      final outCenter = computeAnchorWorldPosition(
        endNode,
        endNode.anchors!.first,
        [startNode, endNode],
      );
      expect(
          tester.hitTestAnchor(outCenter + const Offset(0, -3)), 'out_anchor');

      // 很远位置，返回 null
      expect(tester.hitTestAnchor(const Offset(-100, -100)), isNull);
    });

    test('hitTestEdge detects edge between start and end nodes', () {
      // 获取连线的路径，取路径上一点进行测试
      final pathResult = FlexiblePathGenerator([startNode, endNode])
          .generate(edge, type: edge.lineStyle.edgeMode)!;
      final mid = pathResult.path
          .computeMetrics()
          .first
          .getTangentForOffset(
              pathResult.path.computeMetrics().first.length / 2)!
          .position;

      // mid 点在线上，距离为 0，应命中 edge.id
      expect(tester.hitTestEdge(mid), 'edge1');

      // 离路径很远，返回 null
      expect(tester.hitTestEdge(mid + const Offset(0, 20)), isNull);
    });

    test('hitTestElement priority anchor > node > edge', () {
      // 在 in_anchor 中，优先命中锚点
      final inCenter = computeAnchorWorldPosition(
        startNode,
        startNode.anchors!.first,
        [startNode, endNode],
      );
      expect(tester.hitTestElement(inCenter), 'in_anchor');

      // 在 startNode 区域，但不在 anchor 范围内
      expect(tester.hitTestElement(const Offset(15, 15)), 'start_node');

      // 在 edge 中线，但不在节点/锚点范围
      final pathResult = FlexiblePathGenerator([startNode, endNode])
          .generate(edge, type: edge.lineStyle.edgeMode)!;
      final mid = pathResult.path
          .computeMetrics()
          .first
          .getTangentForOffset(
              pathResult.path.computeMetrics().first.length / 2)!
          .position;
      expect(tester.hitTestElement(mid), 'edge1');
    });
  });
}
