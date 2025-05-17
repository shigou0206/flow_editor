import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/models/node_model.dart';

abstract class NodeWidgetFactory {
  Widget createNodeWidget(NodeModel node);
}
