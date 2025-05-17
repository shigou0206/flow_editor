import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/node/behaviors/node_behavior.dart';

// 引入我们刚才的三段式容器
import 'package:flow_editor/v1/core/node/widgets/components/three_parts_layout.dart';
// 注意：此路径仅作示例，请根据你实际文件结构修改

/// NodeBlock：三段式节点，可响应单击 / 双击 / 右键 / 悬浮 / 删除 等行为
class NodeBlock extends StatefulWidget {
  final NodeModel node;

  /// 头部（可选）
  final Widget? header;

  /// 中间主体（必传）
  final Widget body;

  /// 底部（可选）
  final Widget? footer;

  /// 节点行为
  final NodeBehavior? behavior;

  const NodeBlock({
    super.key,
    required this.node,
    this.header,
    required this.body,
    this.footer,
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

  /// 处理单击 / 双击
  void _onTapUp(TapUpDetails details) {
    if (_waitingForDoubleTap) {
      // 已在等第二次点击 → 这是一次双击
      _tapTimer?.cancel();
      _waitingForDoubleTap = false;
      _handleDoubleTap();
    } else {
      // 第一次点击
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
            // 单击 / 双击
            onTapUp: _onTapUp,
            // 右键(或长按)菜单
            onSecondaryTapDown: (details) => widget.behavior
                ?.onContextMenu(widget.node, details.localPosition),
            child: MouseRegion(
              onEnter: (_) => widget.behavior?.onHover(widget.node, true),
              onExit: (_) => widget.behavior?.onHover(widget.node, false),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 在下层放三段式布局：header / body / footer
                  SizedBox(
                    width: w,
                    height: h,
                    child: ThreePartsLayout(
                      headerHeight: 30.0,
                      footerHeight: 10.0,
                      header: widget.header,
                      body: widget.body,
                      footer: widget.footer,
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
