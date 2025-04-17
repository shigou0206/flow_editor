// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';
// import 'package:flow_editor/core/interactions/drag_policy.dart';
// import 'package:flow_editor/core/interactions/drag_notifier.dart';
// import 'package:flow_editor/core/anchor/models/anchor_model.dart';
// import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
// import 'package:flow_editor/core/interactions/drag_state.dart';
// import 'package:flow_editor/core/interactions/edge_drop_policy.dart';
// import 'package:flow_editor/core/node/models/node_model.dart';

// /// 负责把 Gesture 事件转成「拖拽开始/更新/结束」调用
// /// 并在开始/结束时检查 DragPolicy
// class DragController {
//   final WidgetRef ref;
//   final BuildContext context;
//   late final DragPolicy _policy;

//   DragController(this.ref, this.context) {
//     // 根据当前的交互配置选择策略
//     final cfg = ref.read(multiCanvasStateProvider).activeState.interactionConfig;
//     _policy = cfg.dropOnEdgeOnly
//         ? EdgeDropOnlyPolicy(ref)
//         : DefaultDragPolicy();
//   }

//   /// 用户按下
//   void onTapDown(TapDownDetails details) {
//     // 我们这里直接当做 dragStart
//     startDrag(details.globalPosition);
//   }

//   /// 拖拽开始
//   void onPanStart(DragStartDetails details) {
//     startDrag(details.globalPosition);
//   }

//   void startDrag(Offset globalPos) {
//     // 先判断是不是从某个锚点开始连边
//     final hitAnchor = _hitTestAnchor(globalPos);
//     if (hitAnchor != null &&
//         _policy.canStartEdgeDrag(hitAnchor.nodeId, hitAnchor.id)) {
//       // 开始画一条“幽灵边”
//       ref.read(multiCanvasStateProvider.notifier)
//         .startDrag(context, globalPos);
//       ref.read(dragProvider.notifier)
//         .startEdgeDrag('ghost_${DateTime.now().millisecondsSinceEpoch}', globalPos);
//       return;
//     }

//     // 再判断是不是点击到了已有节点
//     final hitNode = _hitTestNode(globalPos);
//     if (hitNode != null && _policy.canStartNodeDrag(hitNode.id)) {
//       ref.read(multiCanvasStateProvider.notifier)
//         .startDrag(context, globalPos);
//       ref.read(dragProvider.notifier)
//         .startNodeDrag(hitNode.id, globalPos);
//       return;
//     }

//     // 否则当作画布平移
//     ref.read(dragProvider.notifier).reset();
//     ref.read(multiCanvasStateProvider.notifier)
//       .startDrag(context, globalPos);
//   }

//   /// 拖拽更新
//   void onPanUpdate(DragUpdateDetails details) {
//     ref.read(multiCanvasStateProvider.notifier)
//       .updateDrag(details.delta);
//     ref.read(dragProvider.notifier)
//       .update(details.globalPosition);
//   }

//   /// 拖拽结束
//   void onPanEnd(DragEndDetails details) {
//     final drag = ref.read(dragProvider);
//     switch (drag.mode) {
//       case DragMode.edge:
//         _finishEdgeDrag(drag.current);
//         break;
//       case DragMode.node:
//         _finishNodeDrag(drag.current, drag.id!);
//         break;
//       case DragMode.none:
//       case DragMode.external:
//       default:
//         ref.read(multiCanvasStateProvider.notifier).endDrag();
//         break;
//     }
//     ref.read(dragProvider.notifier).reset();
//   }

//   void _finishEdgeDrag(Offset globalPos) {
//     final target = _detectTargetAnchor(globalPos);
//     final notifier = ref.read(edgeStateProvider(
//       ref.read(multiCanvasStateProvider).activeWorkflowId
//     ).notifier);

//     if (target != null && 
//         _policy.canDropEdge('', target.nodeId, target.id)) {
//       notifier.finalizeEdge(
//         edgeId: notifier.state.draggingEdgeId!,
//         targetNodeId: target.nodeId,
//         targetAnchorId: target.id,
//       );
//     }
//     notifier.endEdgeDrag(
//       canceled: target == null,
//       targetNodeId: target?.nodeId,
//       targetAnchorId: target?.id,
//     );
//     ref.read(multiCanvasStateProvider.notifier).endDrag();
//   }

//   void _finishNodeDrag(Offset globalPos, String nodeId) {
//     // 转成 canvas 坐标
//     final canvasSt = ref.read(multiCanvasStateProvider).activeState;
//     final box = context.findRenderObject() as RenderBox;
//     final local = box.globalToLocal(globalPos);
//     final canvasPos = (local - canvasSt.offset) / canvasSt.scale;

//     if (_policy.canDropNode(nodeId, canvasPos)) {
//       // 插入节点
//       ref.read(multiCanvasStateProvider.notifier)
//         .handleExternalDrop(nodeId, canvasPos);
//     } else {
//       // 如果不允许放置，就只是结束拖拽，不插入
//       ref.read(multiCanvasStateProvider.notifier).endDrag();
//     }
//   }

//   AnchorModel? _hitTestAnchor(Offset globalPos) {
//     // 同 MultiCanvasStateNotifier._hitTestAnchor
//     return ref.read(multiCanvasStateProvider.notifier)
//       .hitTestAnchor(context, globalPos);
//   }

//   NodeModel? _hitTestNode(Offset globalPos) {
//     return ref.read(multiCanvasStateProvider.notifier)
//       .hitTestNode(context, globalPos);
//   }

//   AnchorModel? _detectTargetAnchor(Offset globalPos) {
//     return ref.read(multiCanvasStateProvider.notifier)
//       .detectTargetAnchor(context, globalPos);
//   }
// }