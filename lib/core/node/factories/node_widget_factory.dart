import 'package:flutter/widgets.dart';
import '../models/node_model.dart';

abstract class NodeWidgetFactory {
  Widget createNodeWidget(NodeModel node);
}
