import 'package:flutter/material.dart';
import '../models/anchor_model.dart';
import '../painter/anchor_painter.dart';
import '../behaviors/anchor_behavior.dart';

/// AnchorWidget：展示单个锚点的 UI & 交互
class AnchorWidget extends StatefulWidget {
  final AnchorModel anchor;
  final bool isHover;
  final bool isSelected;
  final double baseSize;
  final double scale;
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
    this.baseSize = 24.0,
    this.scale = 1.0,
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

  /// 如果需要做 “逆变换”，这里可扩展
  Offset _toWorldPosition(Offset localPos) {
    return localPos;
  }

  @override
  Widget build(BuildContext context) {
    final double finalSize = widget.baseSize * widget.scale;

    return SizedBox(
      width: finalSize,
      height: finalSize,
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
            final worldPos = _toWorldPosition(details.localPosition);
            debugPrint(
                'AnchorWidget onPanStart: ${widget.anchor.id}, local=${details.localPosition}, world=$worldPos');
            widget.anchorBehavior?.onAnchorDragStart(widget.anchor, worldPos);
            _dragStartPos = worldPos;
            _currentDragPos = worldPos;
          },
          onPanUpdate: (details) {
            final currentWorldPos = _toWorldPosition(details.localPosition);
            debugPrint(
                'AnchorWidget onPanUpdate: ${widget.anchor.id}, local=${details.localPosition}, world=$currentWorldPos');
            widget.anchorBehavior
                ?.onAnchorDragUpdate(widget.anchor, currentWorldPos);
            _currentDragPos = currentWorldPos;
          },
          onPanEnd: (details) {
            final endPos = _currentDragPos ?? _dragStartPos ?? Offset.zero;
            debugPrint(
                'AnchorWidget onPanEnd: ${widget.anchor.id}, end=$endPos');
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
