import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';

class NodeListWidget extends StatelessWidget {
  final List<NodeModel> availableNodes;
  final ValueChanged<NodeModel> onDragCompleted;

  const NodeListWidget({
    super.key,
    required this.availableNodes,
    required this.onDragCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final list = availableNodes;

    return Container(
      width: 250,
      color: Colors.grey.shade100,
      child: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final template = list[index];
          return Draggable<NodeModel>(
            data: template,
            // 拖拽中显示的反馈UI (半透明卡片)
            feedback: _buildDragFeedback(template),
            // 原位置在拖拽时的样式 (加个轻微背景或透明度区分)
            childWhenDragging: _buildDraggingPlaceholder(template),

            child: _buildNodeCard(template),

            // 调试日志
            onDragStarted: () {
              debugPrint('>>> Draggable onDragStarted: ${template.title}');
            },
            onDragEnd: (details) {
              debugPrint(
                  '>>> Draggable onDragEnd: ${template.title}, offset=${details.offset}');
            },
            onDraggableCanceled: (velocity, offset) {
              debugPrint(
                  '>>> Draggable onDraggableCanceled: ${template.title}, offset=$offset');
            },
          );
        },
      ),
    );
  }

  /// 拖拽中的悬浮反馈
  Widget _buildDragFeedback(NodeModel template) {
    return Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Drag: ${template.title}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 原位置在拖拽时的占位 (可加灰底或别的样式)
  Widget _buildDraggingPlaceholder(NodeModel template) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text('[Dragging] ${template.title}'),
    );
  }

  /// 正常状态下的卡片样式
  Widget _buildNodeCard(NodeModel template) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Icon(Icons.add, color: Colors.blue),
          const SizedBox(width: 6),
          Text(
            template.title ?? '',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flow_editor/core/node/models/node_model.dart';

// class NodeListWidget extends StatelessWidget {
//   final List<NodeModel> availableNodes;
//   final ValueChanged<NodeModel> onDragCompleted;

//   const NodeListWidget({
//     Key? key,
//     required this.availableNodes,
//     required this.onDragCompleted,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250,
//       color: Colors.grey.shade100,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         itemCount: availableNodes.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 8),
//         itemBuilder: (context, index) {
//           final template = availableNodes[index];

//           return Draggable<NodeModel>(
//             data: template,
//             // 拖拽中在鼠标/手指下跟随的Widget
//             feedback: _buildDragFeedback(template),
//             // 原位置显示的Widget在半透明时做视觉区分
//             childWhenDragging: Opacity(
//               opacity: 0.3,
//               child: _buildStepFunctionCard(template, isDragging: true),
//             ),
//             // 正常状态下的Widget
//             child: _buildStepFunctionCard(template),

//             // 事件回调
//             onDragStarted: () {
//               debugPrint('>>> Draggable onDragStarted: ${template.title}');
//             },
//             onDragEnd: (details) {
//               debugPrint(
//                   '>>> Draggable onDragEnd: ${template.title}, offset=${details.offset}');
//             },
//             onDraggableCanceled: (velocity, offset) {
//               debugPrint(
//                   '>>> Draggable onDraggableCanceled: ${template.title}, offset=$offset');
//             },
//             onDragCompleted: () => onDragCompleted(template),
//           );
//         },
//       ),
//     );
//   }

//   /// 拖拽进行时的“跟随”Widget（半透明卡片）
//   Widget _buildDragFeedback(NodeModel template) {
//     return Material(
//       color: Colors.transparent,
//       child: Opacity(
//         opacity: 0.85,
//         child: _buildStepFunctionCard(template, isDragging: true),
//       ),
//     );
//   }

//   /// 自定义卡片，模仿 Step Functions 风格（带圆角、背景、边框等）
//   Widget _buildStepFunctionCard(NodeModel template, {bool isDragging = false}) {
//     // 根据是否在拖拽中，选择略微不同的视觉
//     final bgColor = isDragging ? Colors.blue[100] : Colors.blue[50];
//     final borderColor = isDragging ? Colors.blueAccent : Colors.blue.shade600;
//     final textColor = isDragging ? Colors.blue.shade800 : Colors.blue.shade900;

//     // 你也可以改成渐变、或者使用 Container + BoxDecoration
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: bgColor,
//         border: Border.all(color: borderColor, width: 2),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.settings_applications),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 主要标题（节点标题）
//                 Text(
//                   template.title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: textColor,
//                   ),
//                 ),
//                 // 辅助信息
//                 Text(
//                   'Type: ${template.type}',
//                   style: TextStyle(
//                       fontSize: 12, color: textColor.withOpacity(0.7)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
