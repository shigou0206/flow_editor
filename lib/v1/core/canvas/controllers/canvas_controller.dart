import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/v1/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/v1/core/canvas/controllers/canvas_controller_interface.dart';

/// CanvasController 实现 ICanvasController
/// 包含画布平移/缩放、节点操作、以及 边(GhostEdge) 操作
class CanvasController implements ICanvasController {
  final WidgetRef ref;
  final BuildContext context;

  CanvasController({required this.ref, required this.context});

  @override
  void onTapDown(BuildContext context, TapDownDetails details) {
    // 此处以 onTapDown 作为拖拽起点触发，也可根据需求决定是否使用
    ref
        .read(multiCanvasStateProvider.notifier)
        .startDrag(context, details.globalPosition);
  }

  @override
  void onPanStart(BuildContext context, DragStartDetails details) {
    // 拖拽开始时调用，传入全局坐标
    ref
        .read(multiCanvasStateProvider.notifier)
        .startDrag(context, details.globalPosition);
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    // 拖拽更新时传递 delta
    ref.read(multiCanvasStateProvider.notifier).updateDrag(details.delta);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    // 拖拽结束时通知结束拖拽
    ref.read(multiCanvasStateProvider.notifier).endDrag();
  }
}
