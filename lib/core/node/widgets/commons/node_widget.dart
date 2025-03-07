import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/node_model.dart';
import '../../behaviors/node_behavior.dart';
import '../../../anchor/behaviors/anchor_behavior.dart';
import '../../../anchor/utils/anchor_position_utils.dart';
import 'node_block.dart';
import 'node_anchors.dart';

class NodeWidget extends StatefulWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;

  const NodeWidget({
    super.key,
    required this.node,
    required this.child,
    this.behavior,
    this.anchorBehavior,
  });

  @override
  _NodeWidgetState createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget> {
  Timer? _tapTimer;
  bool _waitingForDoubleTap = false;
  static const _doubleTapDelay = Duration(milliseconds: 300);

  /// 单击回调
  void _handleTap() {
    widget.behavior?.onTap(widget.node);
  }

  /// 双击回调
  void _handleDoubleTap() {
    widget.behavior?.onDoubleTap(widget.node);
  }

  /// 用来区分单击或双击
  void _onTapUp(TapUpDetails details) {
    if (_waitingForDoubleTap) {
      // 如果正在等待双击，则取消定时器并视为双击
      _tapTimer?.cancel();
      _waitingForDoubleTap = false;
      _handleDoubleTap();
    } else {
      // 否则启动等待双击的计时
      _waitingForDoubleTap = true;
      _tapTimer = Timer(_doubleTapDelay, () {
        if (_waitingForDoubleTap) {
          _handleTap();
          _waitingForDoubleTap = false;
        }
      });
    }
  }

  /// 拖拽开始，取消单击/双击等待，并调用 NodeBehavior.onDragStart
  void _onPanStart(DragStartDetails details) {
    // 如果用户开始拖动，则不再触发单/双击
    _tapTimer?.cancel();
    _waitingForDoubleTap = false;

    widget.behavior?.onDragStart(widget.node, details);
  }

  /// 拖拽更新，调用 NodeBehavior.onDragUpdate
  void _onPanUpdate(DragUpdateDetails details) {
    widget.behavior?.onDragUpdate(widget.node, details);
  }

  /// 拖拽结束，调用 NodeBehavior.onDragEnd
  void _onPanEnd(DragEndDetails details) {
    widget.behavior?.onDragEnd(widget.node, details);
  }

  @override
  void dispose() {
    _tapTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 计算锚点外扩边距
    final AnchorPadding padding =
        computeAnchorPadding(widget.node.anchors, widget.node);
    // 总宽高：节点尺寸 + 锚点外扩
    final double totalWidth = widget.node.width + padding.left + padding.right;
    final double totalHeight =
        widget.node.height + padding.top + padding.bottom;

    return Positioned(
      left: widget.node.x - padding.left,
      top: widget.node.y - padding.top,
      child: SizedBox(
        width: totalWidth,
        height: totalHeight,
        child: MouseRegion(
          onEnter: (_) => widget.behavior?.onHover(widget.node, true),
          onExit: (_) => widget.behavior?.onHover(widget.node, false),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: _onTapUp,
            onSecondaryTapDown: (details) {
              // 右键菜单
              widget.behavior?.onContextMenu(
                widget.node,
                details.localPosition,
              );
            },
            // 以下三个回调用来处理拖拽
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 节点主体
                Positioned(
                  left: padding.left,
                  top: padding.top,
                  child: NodeBlock(
                    node: widget.node,
                    behavior: widget.behavior,
                    child: widget.child,
                  ),
                ),
                // 锚点层
                Positioned(
                  left: 0,
                  top: 0,
                  child: NodeAnchors(
                    node: widget.node,
                    anchorBehavior: widget.anchorBehavior,
                    padding: padding,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
