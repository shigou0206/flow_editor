import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';

abstract class LayoutStrategy {
  void performLayout(
    List<NodeModel> nodes,
    List<EdgeModel> edges,
  );
}
