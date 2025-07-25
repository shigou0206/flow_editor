import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/enums/node_enums.dart';
import 'package:flow_editor/ui/node/workflow/base/node_widget.dart';

class StartNodeWidget extends StatelessWidget {
  final NodeModel node;

  const StartNodeWidget({
    super.key,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      node: node.copyWith(role: NodeRole.start),
      child: Container(
        width: node.size.width,
        height: node.size.height,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255), // 背景亮灰
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[600]!, width: 2), // ✅ 更亮的边
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Start_${node.id}',
            style: const TextStyle(
                color: Color.fromARGB(255, 100, 100, 100), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
