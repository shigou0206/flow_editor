// import 'package:flutter/material.dart';
// import 'package:flow_editor/core/node/models/node_model.dart';
// import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
// import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
// import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
// import 'package:flow_editor/core/node/widgets/workflows/base/node_block.dart';
// import 'package:flow_editor/core/node/widgets/workflows/base/node_anchors.dart';
// import 'package:flow_editor/core/node/widgets/components/node_body.dart';
// import 'package:flow_editor/core/node/widgets/components/node_header.dart';
// import 'package:flow_editor/core/node/painter/configurable_border_painter.dart';
// import 'package:flow_editor/core/node/plugins/node_action_callbacks.dart';

// class NodeWidget extends StatelessWidget {
//   final NodeModel node;
//   final NodeBehavior? behavior;
//   final AnchorBehavior? anchorBehavior;

//   /// 三段式布局所需：顶部 Header、主体 Body、底部 Footer
//   final Widget? header;
//   final Widget? body;
//   final Widget? footer;

//   // 添加回调函数
//   final NodeActionCallbacks? callbacks;

//   const NodeWidget({
//     super.key,
//     required this.node,
//     this.body,
//     this.header,
//     this.footer,
//     this.behavior,
//     this.anchorBehavior,
//     this.callbacks,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // 1) 计算锚点外扩的边距
//     final AnchorPadding padding = node.anchorPadding;

//     // 2) 总宽高：节点大小 + 锚点外扩
//     final double totalWidth = node.width + padding.left + padding.right;
//     final double totalHeight = node.height + padding.top + padding.bottom;
//     const double headerHeight = 30.0;

//     // 3) 不再返回 Positioned，而是把坐标留给父层去控制
//     return SizedBox(
//       width: totalWidth,
//       height: totalHeight,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           // 3.1 在 (padding.left, padding.top) 放置 NodeBlock (三段式)
//           Positioned(
//             left: padding.left,
//             top: padding.top,
//             child: NodeBlock(
//               node: node,
//               behavior: behavior,
//               header: header ??
//                   NodeHeader(
//                     width: node.width,
//                     height: headerHeight,
//                     buttons: [
//                       NodeHeaderButton(
//                           icon: Icons.play_arrow,
//                           onTap: callbacks?.onRun != null
//                               ? () => callbacks!.onRun!(node)
//                               : () {},
//                           tooltip: 'Run'),
//                       NodeHeaderButton(
//                           icon: Icons.stop,
//                           onTap: callbacks?.onStop != null
//                               ? () => callbacks!.onStop!(node)
//                               : () {},
//                           tooltip: 'Stop'),
//                       NodeHeaderButton(
//                           icon: Icons.delete,
//                           onTap: callbacks?.onDelete != null
//                               ? () => callbacks!.onDelete!(node)
//                               : () {},
//                           tooltip: 'Delete'),
//                       NodeHeaderButton(
//                           icon: Icons.more_vert,
//                           onTap: callbacks?.onMenu != null
//                               ? () => callbacks!.onMenu!(node)
//                               : () {},
//                           tooltip: 'Menu'),
//                     ],
//                   ),
//               body: body ??
//                   NodeBody(
//                     config: const BorderPainterConfig(
//                       mode: BorderDrawMode.staticColor,
//                       shape: BorderShape.roundRect,
//                       staticColor: Colors.grey,
//                     ),
//                     width: node.width,
//                     child: Text(node.title),
//                   ),
//               footer: footer,
//             ),
//           ),

//           // 3.2 在 (0,0) 放置锚点层
//           Positioned(
//             left: 0,
//             top: 0,
//             child: NodeAnchors(
//               node: node,
//               anchorBehavior: anchorBehavior,
//               padding: padding,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/node/widgets/workflows/base/node_block.dart';
import 'package:flow_editor/core/node/widgets/workflows/base/node_anchors.dart';
import 'package:flow_editor/core/node/widgets/components/node_header.dart';
import 'package:flow_editor/core/node/plugins/node_action_callbacks.dart';

class NodeWidget extends StatelessWidget {
  final NodeModel node;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;

  /// 三段式布局所需：顶部 Header、主体 Body、底部 Footer
  final Widget? header;
  final Widget? body;
  final Widget? footer;

  // 添加回调函数
  final NodeActionCallbacks? callbacks;

  const NodeWidget({
    super.key,
    required this.node,
    this.body,
    this.header,
    this.footer,
    this.behavior,
    this.anchorBehavior,
    this.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    // 1) 计算锚点外扩的边距
    final AnchorPadding padding = node.anchorPadding;

    // 2) 总宽高：节点大小 + 锚点外扩
    final double totalWidth = node.width + padding.left + padding.right;
    final double totalHeight = node.height + padding.top + padding.bottom;
    const double headerHeight = 30.0;

    return SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // (1) 在 (padding.left, padding.top) 放置 NodeBlock (三段式)
          Positioned(
            left: padding.left,
            top: padding.top,
            child: NodeBlock(
              node: node,
              behavior: behavior,
              header: header ??
                  NodeHeader(
                    width: node.width,
                    height: headerHeight,
                    buttons: [
                      NodeHeaderButton(
                        icon: Icons.play_arrow,
                        onTap: callbacks?.onRun != null
                            ? () => callbacks!.onRun!(node)
                            : () {},
                        tooltip: 'Run',
                      ),
                      NodeHeaderButton(
                        icon: Icons.stop,
                        onTap: callbacks?.onStop != null
                            ? () => callbacks!.onStop!(node)
                            : () {},
                        tooltip: 'Stop',
                      ),
                      NodeHeaderButton(
                        icon: Icons.delete,
                        onTap: callbacks?.onDelete != null
                            ? () => callbacks!.onDelete!(node)
                            : () {},
                        tooltip: 'Delete',
                      ),
                      NodeHeaderButton(
                        icon: Icons.more_vert,
                        onTap: callbacks?.onMenu != null
                            ? () => callbacks!.onMenu!(node)
                            : () {},
                        tooltip: 'Menu',
                      ),
                    ],
                  ),
              // (2) 直接用一个 Container 做 "body" => Step Functions 样式
              body: body ??
                  Container(
                    width: node.width,
                    // 高度若需要,可以 node.height - headerHeight - footerHeight
                    // 也可让 NodeBlock 自适应
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3FD), // 浅蓝背景
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: const Color(0xFFB8D1F5), // 浅蓝边框
                        width: 1.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      node.title,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
              footer: footer,
            ),
          ),

          // (3) 在 (0,0) 放置锚点层
          Positioned(
            left: 0,
            top: 0,
            child: NodeAnchors(
              node: node,
              anchorBehavior: anchorBehavior,
              padding: padding,
            ),
          ),
        ],
      ),
    );
  }
}
