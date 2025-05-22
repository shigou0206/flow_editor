import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/enums/node_enums.dart';
import 'package:flow_editor/ui/node/workflow/base/node_widget.dart';

class EndNodeWidget extends StatelessWidget {
  final NodeModel node;

  const EndNodeWidget({
    super.key,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      node: node.copyWith(role: NodeRole.end),
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
        child: Center(
          child: Container(
            width: node.size.width / 4,
            height: node.size.height / 3.5,
            decoration: BoxDecoration(
              color: const Color.fromARGB(221, 96, 96, 96),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
