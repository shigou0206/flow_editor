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
    Key? key,
    required this.node,
    required this.child,
    this.behavior,
    this.anchorBehavior,
  }) : super(key: key);

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

  /// TapUp 用来区分单击或双击
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

  @override
  void dispose() {
    _tapTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 计算锚点外扩的边距
    final AnchorPadding padding =
        computeAnchorPadding(widget.node.anchors, widget.node);
    // 总宽高：节点尺寸 + 锚点外扩尺寸
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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 节点主体
                Positioned(
                  left: padding.left,
                  top: padding.top,
                  child: NodeBlock(
                    node: widget.node,
                    child: widget.child,
                    // 删除事件依然可以在 NodeBlock 中调用 behavior
                    // 或者你也可以把删除逻辑也挪到 NodeWidget 中
                    behavior: widget.behavior,
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
