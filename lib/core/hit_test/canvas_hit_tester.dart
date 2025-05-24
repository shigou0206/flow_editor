import 'dart:ui';
import 'package:flow_editor/core/models/node_model.dart';
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
  EdgeModel? hitTestEdgeModel(Offset pos);

  /// 命中 anchor 时，返回包含 nodeId 的 AnchorHitResult（推荐替代 anchorModel）
  AnchorHitResult? hitTestAnchorResult(Offset pos);

  EdgeWaypointPathHitResult? hitTestEdgeWaypointPath(Offset pos);

  // ===== 综合优先级（anchor > node > edge） =====
  String? hitTestElement(Offset pos);

  /// 综合命中模型，按优先级返回 AnchorHitResult / NodeModel / EdgeModel
  Object? hitTestElementModel(Offset pos);

  // ===== 扩展项：高级 UI 区块命中 =====
  ResizeHitResult? hitTestResizeHandle(Offset pos);
  EdgeUiHitResult? hitTestEdgeOverlayElement(Offset pos);
  EdgeWaypointHitResult? hitTestEdgeWaypoint(Offset pos);
  FloatingAnchorHitResult? hitTestFloatingAnchor(Offset pos);
  InsertTargetHitResult? hitTestInsertPoint(Offset pos);

  // 检测矩形区域内的边，并可选地根据鼠标位置确定最接近的边
  String? hitTestEdgeWithRect(Rect rect, [Offset? mouseCanvasPos]);
}
