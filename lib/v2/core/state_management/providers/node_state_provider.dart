import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/node_state_notifier.dart';
import 'package:flow_editor/v2/core/models/node_model.dart';
import '../models/node_state.dart';

final nodeStateProvider =
    StateNotifierProvider.family<NodeStateNotifier, NodeState, String>(
  (ref, wf) => NodeStateNotifier(ref, workflowId: wf),
);

final nodesProvider = Provider.family<List<NodeModel>, String>((ref, wf) {
  final state = ref.watch(nodeStateProvider(wf));
  return state.nodesOf(wf);
});
