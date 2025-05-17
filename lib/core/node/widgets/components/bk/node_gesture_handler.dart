import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/behaviors/node_behavior.dart';

/// NodeGestureHandler 封装了节点的手势处理逻辑，
/// 包括单击、双击以及右键点击（上下文菜单）的事件处理。
///
/// 单击与双击的逻辑通过 [onTapUp] 与一个 [Timer] 实现，
/// 延迟 [doubleTapDelay] 后判断为单击；如果在延迟期间检测到第二次点击，则触发双击。
class NodeGestureHandler extends StatefulWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;
  final Duration doubleTapDelay;

  const NodeGestureHandler({
    super.key,
    required this.node,
    required this.child,
    this.behavior,
    this.doubleTapDelay = const Duration(milliseconds: 300),
  });

  @override
  // ignore: library_private_types_in_public_api
  _NodeGestureHandlerState createState() => _NodeGestureHandlerState();
}

class _NodeGestureHandlerState extends State<NodeGestureHandler> {
  Timer? _tapTimer;
  bool _waitingForDoubleTap = false;

  /// 处理单击事件
  void _handleTap() {
    widget.behavior?.onTap(widget.node);
  }

  /// 处理双击事件
  void _handleDoubleTap() {
    widget.behavior?.onDoubleTap(widget.node);
  }

  /// onTapUp 回调，根据点击次数决定触发单击或双击事件
  void _onTapUp(TapUpDetails details) {
    if (_waitingForDoubleTap) {
      // 如果已经等待双击，则取消定时器，触发双击
      _tapTimer?.cancel();
      _waitingForDoubleTap = false;
      _handleDoubleTap();
    } else {
      // 首次点击，启动定时器等待是否有第二次点击
      _waitingForDoubleTap = true;
      _tapTimer = Timer(widget.doubleTapDelay, () {
        if (_waitingForDoubleTap) {
          _handleTap();
          _waitingForDoubleTap = false;
        }
      });
    }
  }

  @override
  void dispose() {
    _tapTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key('node_gesture_detector'),
      behavior: HitTestBehavior.opaque,
      onTapUp: _onTapUp,
      onSecondaryTapDown: (details) {
        widget.behavior?.onContextMenu(widget.node, details.localPosition);
      },
      child: widget.child,
    );
  }
}
