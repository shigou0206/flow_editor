// lib/flow_editor/core/canvas/interaction/drag_notifier.dart

import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/v1/core/interactions/drag_state.dart';

class DragNotifier extends StateNotifier<DragState> {
  DragNotifier() : super(const DragState.none());

  void startNodeDrag(String nodeId, Offset globalPos) {
    state = DragState.node(nodeId, globalPos);
  }

  void startEdgeDrag(String edgeId, Offset globalPos) {
    state = DragState.edge(edgeId, globalPos);
  }

  void startExternalDrag(dynamic payload, Offset globalPos) {
    state = DragState.external(payload, globalPos);
  }

  void update(Offset globalPos) {
    if (state.mode == DragMode.none) return;
    state = state.copyWithCurrent(globalPos);
  }

  void reset() {
    state = const DragState.none();
  }
}

final dragProvider =
    StateNotifierProvider<DragNotifier, DragState>((_) => DragNotifier());
