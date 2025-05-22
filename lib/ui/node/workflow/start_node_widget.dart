import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
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
          shape: BoxShape.circle,
          color: Colors.grey[100],
          border: Border.all(color: Colors.black87, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Start',
            style: TextStyle(
              color: Color.fromARGB(221, 19, 19, 19),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
