import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';
import 'package:flow_editor/v1/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/v1/core/edge/edge_state/edge_state_provider.dart';

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
