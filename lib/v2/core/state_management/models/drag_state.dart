import 'dart:ui';

class DragState {
  const DragState({
    this.edgeId,
    this.draggingEnd,
  });

  final String? edgeId; // ghost-edge id
  final Offset? draggingEnd; // world pos

  DragState copyWith({
    String? edgeId,
    Offset? draggingEnd,
    bool clearId = false,
    bool clearPos = false,
  }) =>
      DragState(
        edgeId: clearId ? null : (edgeId ?? this.edgeId),
        draggingEnd: clearPos ? null : (draggingEnd ?? this.draggingEnd),
      );

  bool get active => edgeId != null;
}
