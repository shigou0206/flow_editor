// core/canvas/controllers/canvas_mode_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/canvas/models/canvas_interaction_mode.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';

/// CanvasModeController: 管理或切换画布的交互模式
class CanvasModeController {
  final Ref ref;

  CanvasModeController(this.ref);

  /// 获取当前模式
  CanvasInteractionMode getMode() {
    final st = ref.read(multiCanvasStateProvider);
    return st.activeState.interactionMode;
  }

  /// 是否处于某种模式
  bool isMode(CanvasInteractionMode mode) {
    return getMode() == mode;
  }
}
