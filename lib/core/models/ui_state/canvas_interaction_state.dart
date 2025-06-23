import 'dart:ui';

class CanvasInteractionState {
  final bool isPanning;
  final Offset? panStartPos;
  final bool isDraggingNode;
  final String? draggingNodeId;
  final bool isDraggingEdge;
  final Offset? nodeDragStartPos;
  final Rect? marqueeRect;
  final String? hoverNodeId;
  final String? hoverEdgeId;
  final String? drawingFromAnchorId;

  const CanvasInteractionState({
    this.isPanning = false,
    this.panStartPos,
    this.isDraggingNode = false,
    this.draggingNodeId,
    this.isDraggingEdge = false,
    this.nodeDragStartPos,
    this.marqueeRect,
    this.hoverNodeId,
    this.hoverEdgeId,
    this.drawingFromAnchorId,
  });

  CanvasInteractionState copyWith({
    bool? isPanning,
    Offset? panStartPos,
    bool? isDraggingNode,
    String? draggingNodeId,
    bool? isDraggingEdge,
    Offset? nodeDragStartPos,
    Rect? marqueeRect,
    bool resetMarquee = false,
    String? hoverNodeId,
    String? hoverEdgeId,
    String? drawingFromAnchorId,
  }) {
    return CanvasInteractionState(
      isPanning: isPanning ?? this.isPanning,
      panStartPos: panStartPos ?? this.panStartPos,
      isDraggingNode: isDraggingNode ?? this.isDraggingNode,
      draggingNodeId: draggingNodeId ?? this.draggingNodeId,
      isDraggingEdge: isDraggingEdge ?? this.isDraggingEdge,
      nodeDragStartPos: nodeDragStartPos ?? this.nodeDragStartPos,
      marqueeRect: resetMarquee ? null : (marqueeRect ?? this.marqueeRect),
      hoverNodeId: hoverNodeId ?? this.hoverNodeId,
      hoverEdgeId: hoverEdgeId ?? this.hoverEdgeId,
      drawingFromAnchorId: drawingFromAnchorId ?? this.drawingFromAnchorId,
    );
  }

  Map<String, dynamic> toJson() => {
        'isPanning': isPanning,
        'panStartPos':
            panStartPos == null ? null : [panStartPos!.dx, panStartPos!.dy],
        'isDraggingNode': isDraggingNode,
        'draggingNodeId': draggingNodeId,
        'isDraggingEdge': isDraggingEdge,
        'nodeDragStartPos': nodeDragStartPos == null
            ? null
            : [nodeDragStartPos!.dx, nodeDragStartPos!.dy],
        'marqueeRect': marqueeRect == null
            ? null
            : [
                marqueeRect!.left,
                marqueeRect!.top,
                marqueeRect!.right,
                marqueeRect!.bottom
              ],
        'hoverNodeId': hoverNodeId,
        'hoverEdgeId': hoverEdgeId,
        'drawingFromAnchorId': drawingFromAnchorId,
      };

  factory CanvasInteractionState.fromJson(Map<String, dynamic> json) {
    Offset? parseOffset(List? val) =>
        val is List && val.length == 2 ? Offset(val[0], val[1]) : null;
    Rect? parseRect(List? val) => val is List && val.length == 4
        ? Rect.fromLTRB(val[0], val[1], val[2], val[3])
        : null;

    return CanvasInteractionState(
      isPanning: json['isPanning'] ?? false,
      panStartPos: parseOffset(json['panStartPos']),
      isDraggingNode: json['isDraggingNode'] ?? false,
      draggingNodeId: json['draggingNodeId'],
      isDraggingEdge: json['isDraggingEdge'] ?? false,
      nodeDragStartPos: parseOffset(json['nodeDragStartPos']),
      marqueeRect: parseRect(json['marqueeRect']),
      hoverNodeId: json['hoverNodeId'],
      hoverEdgeId: json['hoverEdgeId'],
      drawingFromAnchorId: json['drawingFromAnchorId'],
    );
  }
}
