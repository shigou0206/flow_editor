import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/controller/impl/canvas_controller_impl.dart';
import 'package:flow_editor/core/state_management/providers.dart'
    show activeWorkflowIdProvider, editorStoreFamilyProvider;

/// 1) 每个 workflow 独享一份 CanvasControllerImpl
final canvasControllerFamilyProvider =
    Provider.family<CanvasControllerImpl, String>((ref, workflowId) {
  final storeNotifier =
      ref.watch(editorStoreFamilyProvider(workflowId).notifier);
  return CanvasControllerImpl(storeNotifier.commandContext);
});

/// 2) 当前激活 workflow 的 controller
final activeCanvasControllerProvider = Provider<CanvasControllerImpl>((ref) {
  final workflowId = ref.watch(activeWorkflowIdProvider);
  return ref.watch(canvasControllerFamilyProvider(workflowId));
});
