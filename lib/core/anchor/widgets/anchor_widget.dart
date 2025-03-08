import 'package:flutter/material.dart';
import '../models/anchor_model.dart';
import '../painter/anchor_painter.dart';
import '../behaviors/anchor_behavior.dart';

/// AnchorWidget：展示单个锚点的 UI & 交互
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
  Offset? _dragStartPos;
  Offset? _currentDragPos;

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
          onPanStart: (details) {
            widget.anchorBehavior
                ?.onAnchorDragStart(widget.anchor, details.localPosition);
            _dragStartPos = details.localPosition;
            _currentDragPos = details.localPosition;
          },
          onPanUpdate: (details) {
            widget.anchorBehavior
                ?.onAnchorDragUpdate(widget.anchor, details.localPosition);
            _currentDragPos = details.localPosition;
          },
          onPanEnd: (details) {
            final endPos = _currentDragPos ?? _dragStartPos ?? Offset.zero;
            widget.anchorBehavior
                ?.onAnchorDragEnd(widget.anchor, endPos, canceled: false);
            _dragStartPos = null;
            _currentDragPos = null;
          },
          onPanCancel: () {
            widget.anchorBehavior
                ?.onAnchorDragEnd(widget.anchor, Offset.zero, canceled: true);
            _dragStartPos = null;
            _currentDragPos = null;
          },
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
