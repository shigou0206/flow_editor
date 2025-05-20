// // lib/flow_editor/core/canvas/interaction/edge_drop_policy.dart

// import 'dart:ui';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flow_editor/core/state_management/providers/edge_state_provider.dart';
// import 'package:flow_editor/core/state_management/providers/node_state_provider.dart';
// import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
// import 'package:flow_editor/core/utils/hit_test_utils.dart';
// import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
// import 'drag_policy.dart';

// /// 只允许把外部节点放到已有连线上
// class EdgeDropOnlyPolicy implements DragPolicy {
//   final WidgetRef _ref;
//   EdgeDropOnlyPolicy(this._ref);

//   @override
//   bool canStartNodeDrag(String nodeId) => true;

//   @override
//   bool canDropNode(String nodeId, Offset canvasPos) {
//     final wf =
//         _ref.read(multiCanvasStateProvider.select((s) => s.activeWorkflowId));
//     final edges = _ref.read(edgeStateProvider(wf)).edgesOf(wf);
//     final nodes = _ref.read(nodeStateProvider(wf)).nodesOf(wf);
//     final generator = FlexiblePathGenerator(nodes);

//     for (final e in edges) {
//       if (e.targetNodeId == null) continue;
//       final result = generator.generate(e, type: e.lineStyle.edgeMode);
//       if (result == null) continue;
//       final dist = distanceToPath(result.path, canvasPos);
//       if (dist < 10.0) return true;
//     }
//     return false;
//   }

//   @override
//   bool canStartEdgeDrag(String nodeId, String anchorId) => true;

//   @override
//   bool canDropEdge(String edgeId, String targetNodeId, String targetAnchorId) =>
//       true;
// }
