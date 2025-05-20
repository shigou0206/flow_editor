// lib/core/hit_test/canvas_hit_tester.dart

import 'dart:ui';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/hit_test_result.dart';

/// 命中测试器的统一抽象接口。
abstract class CanvasHitTester {
  // ===== ID-based 命中 =====
  String? hitTestNode(Offset pos);
  String? hitTestAnchor(Offset pos);
  String? hitTestEdge(Offset pos);

  // ===== Model-based 命中 =====
  NodeModel? hitTestNodeModel(Offset pos);
  AnchorModel? hitTestAnchorModel(Offset pos);
  EdgeModel? hitTestEdgeModel(Offset pos);

  // ===== 综合优先级（anchor > node > edge） =====
  String? hitTestElement(Offset pos);
  dynamic hitTestElementModel(Offset pos);

  // ===== 扩展项：高级 UI 区块命中 =====
  ResizeHitResult? hitTestResizeHandle(Offset pos);
  EdgeUiHitResult? hitTestEdgeOverlayElement(Offset pos);
  EdgeWaypointHitResult? hitTestEdgeWaypoint(Offset pos);
  FloatingAnchorHitResult? hitTestFloatingAnchor(Offset pos);
  InsertTargetHitResult? hitTestInsertPoint(Offset pos);
}
