// lib/flow_editor/core/canvas/interaction/drag_state.dart

import 'dart:ui';

/// 拖拽模式
enum DragMode { none, node, edge, external }

/// 拖拽状态
class DragState {
  final DragMode mode;
  final String? id; // nodeId 或 edgeId
  final dynamic payload; // Draggable 里带过来的原始 data
  final Offset start;
  final Offset current;

  const DragState._({
    required this.mode,
    this.id,
    this.payload,
    required this.start,
    required this.current,
  });

  const DragState.none()
      : this._(mode: DragMode.none, start: Offset.zero, current: Offset.zero);

  DragState copyWithCurrent(Offset pos) => DragState._(
        mode: mode,
        id: id,
        payload: payload,
        start: start,
        current: pos,
      );

  static DragState node(String nodeId, Offset start) => DragState._(
        mode: DragMode.node,
        id: nodeId,
        start: start,
        current: start,
      );

  static DragState edge(String edgeId, Offset start) => DragState._(
        mode: DragMode.edge,
        id: edgeId,
        start: start,
        current: start,
      );

  static DragState external(dynamic payload, Offset start) => DragState._(
        mode: DragMode.external,
        id: (payload as dynamic).id as String?,
        payload: payload,
        start: start,
        current: start,
      );
}
