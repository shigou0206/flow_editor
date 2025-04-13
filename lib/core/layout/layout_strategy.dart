import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/node/models/node_model.dart';

abstract class LayoutStrategy {
  void performLayout(
    List<NodeModel> nodes,
    List<EdgeModel> edges,
  );
}
