import '../../node/models/node_model.dart';
import '../../edge/models/edge_model.dart';
import '../../node/node_state/node_state_provider.dart';
import '../../edge/edge_state/edge_state_provider.dart';

abstract class WorkflowModeStrategy {
  void onNodeDeleted({
    required NodeModel deletedNode,
    required List<NodeModel> upstreamNodes,
    required List<NodeModel> downstreamNodes,
    required EdgeStateNotifier edgeNotifier,
    required NodeStateNotifier nodeNotifier,
  });

  void validate({
    required List<NodeModel> nodes,
    required List<EdgeModel> edges,
    required NodeStateNotifier nodeNotifier,
  });
}
