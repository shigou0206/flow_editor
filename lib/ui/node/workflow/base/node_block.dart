import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';

// 引入我们刚才的三段式容器
import 'package:flow_editor/ui/node/components/three_parts_layout.dart';
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

  const NodeBlock({
    super.key,
    required this.node,
    this.header,
    required this.body,
    this.footer,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NodeBlockState createState() => _NodeBlockState();
}

class _NodeBlockState extends State<NodeBlock> {
  @override
  void dispose() {
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
        );
      },
    );
  }
}
