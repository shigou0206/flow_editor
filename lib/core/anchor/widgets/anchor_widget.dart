import 'package:flutter/material.dart';
import '../models/anchor_model.dart';
import '../painter/anchor_painter.dart';
import '../behaviors/anchor_behavior.dart';

/// AnchorWidget：展示单个锚点的 UI 和 hover 效果
/// 修改后删除了拖拽相关的手势事件，避免与父层的 ghost edge 拖拽逻辑冲突
class AnchorWidget extends StatefulWidget {
  final AnchorModel anchor;
  final bool isHover;
  final bool isSelected;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final VoidCallback? onHoverEnter;
  final VoidCallback? onHoverExit;
  final MouseCursor cursor;
  final AnchorBehavior? anchorBehavior;

  const AnchorWidget({
    Key? key,
    required this.anchor,
    this.isHover = false,
    this.isSelected = false,
    this.width = 24.0,
    this.height = 24.0,
    this.onTap,
    this.onHoverEnter,
    this.onHoverExit,
    this.cursor = SystemMouseCursors.precise,
    this.anchorBehavior,
  }) : super(key: key);

  @override
  State<AnchorWidget> createState() => _AnchorWidgetState();
}

class _AnchorWidgetState extends State<AnchorWidget> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: MouseRegion(
        cursor: widget.cursor,
        onEnter: (_) {
          setState(() => _hovering = true);
          widget.onHoverEnter?.call();
        },
        onExit: (_) {
          setState(() => _hovering = false);
          widget.onHoverExit?.call();
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          // 拖拽事件去掉，统一由父级（例如 CanvasGestureHandler）处理 ghost edge 拖拽逻辑
          child: CustomPaint(
            painter: AnchorPainter(
              anchor: widget.anchor,
              isHover: widget.isHover || _hovering,
              isSelected: widget.isSelected,
            ),
          ),
        ),
      ),
    );
  }
}
