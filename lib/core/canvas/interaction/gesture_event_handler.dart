import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 假设这些是您自定义的枚举/Provider
import '../../state_management/canvas_state/canvas_state_provider.dart';
import '../../canvas/models/canvas_interaction_mode.dart';

/// CanvasGestureHandler
/// - 监听 PointerDown/Move/Up
/// - 根据 [CanvasInteractionMode] 决定执行“节点拖拽”或“连线绘制”
class CanvasGestureHandler extends ConsumerStatefulWidget {
  /// 需要包裹的子Widget，一般是CanvasRenderer或Stack等
  final Widget child;

  const CanvasGestureHandler({Key? key, required this.child}) : super(key: key);

  @override
  ConsumerState<CanvasGestureHandler> createState() =>
      _CanvasGestureHandlerState();
}

class _CanvasGestureHandlerState extends ConsumerState<CanvasGestureHandler> {
  // 记录是否正在创建连线
  bool _isCreatingEdge = false;
  String? _creatingEdgeId; // 如果您需要在拖拽中存“半连接”的 Edge ID

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (pointerEvent) {
        final mode = ref.read(multiCanvasStateProvider).activeState.mode;

        if (mode == CanvasInteractionMode.createEdge) {
          // 1) 进入“创建连线”流程
          _startEdgeCreation(pointerEvent.position);
        } else {
          // 2) 否则默认 => 尝试节点拖拽
          ref
              .read(multiCanvasStateProvider.notifier)
              .startDrag(pointerEvent.position);
        }
      },
      onPointerMove: (pointerEvent) {
        final mode = ref.read(multiCanvasStateProvider).activeState.mode;

        if (mode == CanvasInteractionMode.createEdge && _isCreatingEdge) {
          // 如果正在连线 => 让 ghost line 跟随鼠标
          _updateEdgeDrag(pointerEvent.position);
        } else {
          // 否则节点拖拽
          ref
              .read(multiCanvasStateProvider.notifier)
              .updateDrag(pointerEvent.delta);
        }
      },
      onPointerUp: (pointerEvent) {
        final mode = ref.read(multiCanvasStateProvider).activeState.mode;

        if (mode == CanvasInteractionMode.createEdge && _isCreatingEdge) {
          // 完成连线
          _endEdgeCreation(pointerEvent.position);
        } else {
          // 结束节点拖拽
          ref.read(multiCanvasStateProvider.notifier).endDrag();
        }
      },
      child: widget.child,
    );
  }

  //================= 连线创建: 私有方法演示 =================//

  void _startEdgeCreation(Offset globalPos) {
    setState(() {
      _isCreatingEdge = true;
    });
    // 在 multiCanvasStateProvider.notifier 里实现
    // 例如: “startEdgeDrag(Offset globalPos) => new half-connected edge?”
    final multiCanvas = ref.read(multiCanvasStateProvider.notifier);
    final createdEdgeId = multiCanvas.startEdgeDrag(globalPos);
    if (createdEdgeId != null) {
      _creatingEdgeId = createdEdgeId;
    }
  }

  void _updateEdgeDrag(Offset globalPos) {
    if (!_isCreatingEdge || _creatingEdgeId == null) return;

    // 让 ghost line 的终点跟随鼠标 => updateEdgeDrag
    final multiCanvas = ref.read(multiCanvasStateProvider.notifier);
    multiCanvas.updateEdgeDrag(_creatingEdgeId!, globalPos);
  }

  void _endEdgeCreation(Offset globalPos) {
    setState(() {
      _isCreatingEdge = false;
    });
    final multiCanvas = ref.read(multiCanvasStateProvider.notifier);
    // endEdgeDrag => 若鼠标落在另一个节点锚点, 即成真正连线
    multiCanvas.endEdgeDrag(_creatingEdgeId!, globalPos);
    _creatingEdgeId = null;
  }
}
