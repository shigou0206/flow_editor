import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/node_model.dart';

abstract class LayoutStrategy {
  void performLayout(
    List<NodeModel> nodes,
    List<EdgeModel> edges,
  );
}
