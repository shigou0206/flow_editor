import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/state_management/providers/node_state_provider.dart';
import 'package:flow_editor/core/state_management/providers/edge_state_provider.dart';

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
