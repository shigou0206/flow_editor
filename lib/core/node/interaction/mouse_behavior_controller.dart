import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/interaction/node_interaction_controller.dart';

/// MouseBehaviorController 是一个 [InheritedWidget]，
/// 用于在节点组件树中向下传递统一的交互控制器。
///
/// 这样，子组件无需显式传递控制器，只需要通过 [MouseBehaviorController.of(context)]
/// 即可获取统一的鼠标交互回调，例如 onTap、onHover、onContextMenu 等。
class MouseBehaviorController extends InheritedWidget {
  final NodeInteractionController controller;

  const MouseBehaviorController({
    super.key,
    required this.controller,
    required super.child,
  });

  /// 通过上下文获取当前的 [NodeInteractionController]。
  static NodeInteractionController? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MouseBehaviorController>()
        ?.controller;
  }

  @override
  bool updateShouldNotify(MouseBehaviorController oldWidget) {
    return controller != oldWidget.controller;
  }
}
