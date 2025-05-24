// lib/core/state_management/canvas_hit_tester_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/hit_test/default_canvas_hit_tester.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/state_management/providers.dart'
    show activeWorkflowIdProvider, activeEditorStateProvider;
import 'package:flow_editor/core/utils/anchor_position_utils.dart';

final canvasHitTesterFamilyProvider =
    Provider.family<CanvasHitTester, String>((ref, workflowId) {
  return DefaultCanvasHitTester(
    getNodes: () => ref.watch(activeEditorStateProvider).nodeState.nodes,
    getEdges: () => ref.watch(activeEditorStateProvider).edgeState.edges,
    computeAnchorWorldPosition: computeAnchorWorldPosition,
  );
});

final activeCanvasHitTesterProvider = Provider<CanvasHitTester>((ref) {
  final workflowId = ref.watch(activeWorkflowIdProvider);
  return ref.watch(canvasHitTesterFamilyProvider(workflowId));
});
