import 'package:flutter/widgets.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';

abstract class NodeWidgetFactory {
  Widget createNodeWidget(NodeModel node);
}
