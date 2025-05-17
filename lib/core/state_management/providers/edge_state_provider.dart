import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/edge_state.dart';
import '../notifiers/edge_state_notifier.dart';

/// family Provider：`workflowId` ➜ EdgeStateNotifier
final edgeStateProvider =
    StateNotifierProvider.family<EdgeStateNotifier, EdgeState, String>(
  (ref, workflowId) => EdgeStateNotifier(workflowId: workflowId),
);
