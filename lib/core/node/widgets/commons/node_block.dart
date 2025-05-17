import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/behaviors/node_behavior.dart';

/// NodeBlock：节点主体 (可带删除按钮, 可双击/右键等交互)
class NodeBlock extends StatefulWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;

  const NodeBlock({
    super.key,
    required this.node,
    required this.child,
    this.behavior,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NodeBlockState createState() => _NodeBlockState();
}

class _NodeBlockState extends State<NodeBlock> {
  Timer? _tapTimer;
  bool _waitingForDoubleTap = false;
  static const _doubleTapDelay = Duration(milliseconds: 300);

  void _handleTap() => widget.behavior?.onTap(widget.node);
  void _handleDoubleTap() => widget.behavior?.onDoubleTap(widget.node);

  void _onTapUp(TapUpDetails details) {
    if (_waitingForDoubleTap) {
      _tapTimer?.cancel();
      _waitingForDoubleTap = false;
      _handleDoubleTap();
    } else {
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
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final double w = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : widget.node.size.width;
        final double h = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : widget.node.size.height;

        return SizedBox(
          width: w,
          height: h,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: _onTapUp,
            onSecondaryTapDown: (details) => widget.behavior
                ?.onContextMenu(widget.node, details.localPosition),
            child: MouseRegion(
              onEnter: (_) => widget.behavior?.onHover(widget.node, true),
              onExit: (_) => widget.behavior?.onHover(widget.node, false),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: widget.child,
                  ),
                  // 删除按钮，使用 Positioned 放置于右上角（可溢出显示）
                  Positioned(
                    top: -10,
                    right: -10,
                    width: 24,
                    height: 24,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        maxWidth: 24,
                        maxHeight: 24,
                      ),
                      iconSize: 18,
                      icon: const Icon(Icons.delete),
                      onPressed: () => widget.behavior?.onDelete(widget.node),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
