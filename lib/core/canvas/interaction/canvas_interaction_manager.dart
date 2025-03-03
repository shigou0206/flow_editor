import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 假设 multiCanvasStateProvider 是您在 multi_canvas_state_provider.dart 里定义的
import '../../state_management/canvas_state/canvas_state_provider.dart';

/// CanvasInteractionManager
/// - 封装对 multiCanvasStateProvider.notifier 的调用
/// - 也可以自己存一些临时变量, 但一般由 multiCanvasStateNotifier 负责存状态
class CanvasInteractionManager {
  final Ref ref;

  CanvasInteractionManager(this.ref);

  /// 当用户按下 (PointerDown) => 调用 "startDrag"
  void onPanStart(Offset globalPos) {
    ref.read(multiCanvasStateProvider.notifier).startDrag(globalPos);
  }

  /// 当用户移动 (PointerMove) => 调用 "updateDrag"
  void onPanUpdate(Offset deltaGlobal) {
    ref.read(multiCanvasStateProvider.notifier).updateDrag(deltaGlobal);
  }

  /// 当用户抬起 (PointerUp) => 调用 "endDrag"
  void onPanEnd() {
    ref.read(multiCanvasStateProvider.notifier).endDrag();
  }

  // 您也可添加更多逻辑，如 "onDoubleTap, onRightClick" 等
  // 或者编写 "onWheelScroll" 来调用 multiCanvasStateNotifier.zoomAtPoint
}
