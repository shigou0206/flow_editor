import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/enums/node_enums.dart';
import 'package:flow_editor/ui/node/workflow/base/node_widget.dart';

class PlaceholderNodeWidget extends StatelessWidget {
  final NodeModel node;

  const PlaceholderNodeWidget({
    super.key,
    required this.node,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      node: node.copyWith(role: NodeRole.placeholder),
      child: Container(
        width: node.size.width,
        height: node.size.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 2,
            style: BorderStyle.solid,
          ),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: Center(
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.grey,
              size: 32,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
