import 'package:flow_editor/core/models/config/cursor_behavior_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart'
    show activeWorkflowIdProvider, activeEditorStateProvider;

final cursorBehaviorConfigFamilyProvider =
    Provider.family<CursorBehaviorConfig, String>((ref, workflowId) {
  return ref.watch(activeEditorStateProvider).cursorBehaviorConfig;
});

final activeCursorBehaviorConfigProvider =
    Provider<CursorBehaviorConfig>((ref) {
  final workflowId = ref.watch(activeWorkflowIdProvider);
  return ref.watch(cursorBehaviorConfigFamilyProvider(workflowId));
});
