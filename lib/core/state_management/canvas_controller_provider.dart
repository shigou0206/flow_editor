// lib/core/state_management/canvas_controller_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/controller/impl/canvas_controller_impl.dart';
import 'package:flow_editor/core/state_management/providers.dart'
    show
        activeWorkflowIdProvider,
        editorStoreFamilyProvider; // ← 最新 providers 文件中的导出

/// ---------------------------------------------------------------------------
/// 1)  每个 workflow 独享一份 CanvasController（family 版）
final canvasControllerFamilyProvider =
    Provider.family<CanvasController, String>((ref, workflowId) {
  // 取到对应 workflow 的 EditorStoreNotifier
  final storeNotifier =
      ref.watch(editorStoreFamilyProvider(workflowId).notifier);

  // 让 CanvasController 复用该 store 的 CommandContext
  // （保证行为层操作和命令层共用同一套 undo/redo）
  return CanvasController(storeNotifier.commandContext);
});

/// ---------------------------------------------------------------------------
/// 2)  当前激活 workflow 的 CanvasController（UI 层用这个即可）
final activeCanvasControllerProvider = Provider<CanvasController>((ref) {
  final workflowId = ref.watch(activeWorkflowIdProvider);
  return ref.watch(canvasControllerFamilyProvider(workflowId));
});
