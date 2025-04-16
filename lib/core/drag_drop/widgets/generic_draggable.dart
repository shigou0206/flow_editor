// lib/flow_editor/core/drag_drop/widgets/generic_draggable.dart
import 'package:flutter/material.dart';

/// 利用 Builder 模式动态构建外观和反馈
typedef DraggableChildBuilder<T> = Widget Function(
    BuildContext context, T data);
typedef DragFeedbackBuilder<T> = Widget Function(BuildContext context, T data);

class GenericDraggable<T extends Object> extends StatelessWidget {
  final T data;

  /// 构建正常显示的 widget
  final DraggableChildBuilder<T> childBuilder;

  /// 构建拖拽时显示的反馈 widget
  final DragFeedbackBuilder<T> feedbackBuilder;

  /// 拖拽时，原 widget 的替代显示效果，可以为空
  final Widget? childWhenDragging;

  /// 如果只允许沿某一轴拖拽（例如上下或左右）
  final Axis? axis;
  final VoidCallback? onDragStarted;
  final VoidCallback? onDragCompleted;
  final Function(Velocity velocity, Offset offset)? onDraggableCanceled;

  const GenericDraggable({
    super.key,
    required this.data,
    required this.childBuilder,
    required this.feedbackBuilder,
    this.childWhenDragging,
    this.axis,
    this.onDragStarted,
    this.onDragCompleted,
    this.onDraggableCanceled,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<T>(
      data: data,
      axis: axis,
      feedback: Material(
        // 用 Material 包裹反馈 widget，以确保显示阴影和视觉效果
        elevation: 4.0,
        child: feedbackBuilder(context, data),
      ),
      childWhenDragging: childWhenDragging ??
          Opacity(
            opacity: 0.5,
            child: childBuilder(context, data),
          ),
      onDragStarted: onDragStarted,
      onDraggableCanceled: onDraggableCanceled,
      onDragCompleted: onDragCompleted,
      child: childBuilder(context, data),
    );
  }
}
