import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/node/models/node_model.dart';

abstract class NodeWidgetFactory {
  Widget createNodeWidget(NodeModel node);
}
