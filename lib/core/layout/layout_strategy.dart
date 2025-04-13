import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';

abstract class LayoutStrategy {
  void performLayout(
    List<NodeModel> nodes,
    List<EdgeModel> edges,
    NodeStateNotifier nodeNotifier,
    EdgeStateNotifier edgeNotifier,
  );
}
