import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/canvas_state/canvas_state_provider.dart';
import '../../canvas/models/canvas_interaction_mode.dart';
import '../behaviors/canvas_behavior.dart';

class CanvasGestureHandler extends ConsumerStatefulWidget {
  final Widget child;
  final CanvasBehavior canvasBehavior;

  const CanvasGestureHandler({
    Key? key,
    required this.child,
    required this.canvasBehavior,
  }) : super(key: key);

  @override
  ConsumerState<CanvasGestureHandler> createState() =>
      _CanvasGestureHandlerState();
}

class _CanvasGestureHandlerState extends ConsumerState<CanvasGestureHandler> {
  bool _isCreatingEdge = false;
  String? _creatingEdgeId;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      child: widget.child,
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    final mode = ref.read(multiCanvasStateProvider).activeState.mode;

    switch (mode) {
      case CanvasInteractionMode.createEdge:
        _startEdgeCreation(event.position);
        break;
      case CanvasInteractionMode.editNode:
        ref.read(multiCanvasStateProvider.notifier).startDrag(event.position);
        break;
      case CanvasInteractionMode.panCanvas:
        widget.canvasBehavior.startPan(event.position);
        break;
      default:
        break;
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    final mode = ref.read(multiCanvasStateProvider).activeState.mode;

    switch (mode) {
      case CanvasInteractionMode.createEdge:
        if (_isCreatingEdge) {
          _updateEdgeDrag(event.position);
        }
        break;
      case CanvasInteractionMode.editNode:
        ref.read(multiCanvasStateProvider.notifier).updateDrag(event.delta);
        break;
      case CanvasInteractionMode.panCanvas:
        widget.canvasBehavior.updatePan(event.position);
        break;
      default:
        break;
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    final mode = ref.read(multiCanvasStateProvider).activeState.mode;

    switch (mode) {
      case CanvasInteractionMode.createEdge:
        if (_isCreatingEdge) {
          _endEdgeCreation(event.position);
        }
        break;
      case CanvasInteractionMode.editNode:
        ref.read(multiCanvasStateProvider.notifier).endDrag();
        break;
      case CanvasInteractionMode.panCanvas:
        widget.canvasBehavior.endPan();
        break;
      default:
        break;
    }
  }

  void _startEdgeCreation(Offset globalPos) {
    setState(() {
      _isCreatingEdge = true;
    });
    final multiCanvas = ref.read(multiCanvasStateProvider.notifier);
    _creatingEdgeId = multiCanvas.startEdgeDrag(globalPos);
  }

  void _updateEdgeDrag(Offset globalPos) {
    if (_creatingEdgeId == null) return;

    final multiCanvas = ref.read(multiCanvasStateProvider.notifier);
    multiCanvas.updateEdgeDrag(_creatingEdgeId!, globalPos);
  }

  void _endEdgeCreation(Offset globalPos) {
    setState(() {
      _isCreatingEdge = false;
    });
    if (_creatingEdgeId == null) return;

    final multiCanvas = ref.read(multiCanvasStateProvider.notifier);
    multiCanvas.endEdgeDrag(_creatingEdgeId!, globalPos);
    _creatingEdgeId = null;
  }
}
