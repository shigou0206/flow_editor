// lib/core/input/controller/canvas_controller.dart

import 'dart:ui';

import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/controller/canvas_controller_interface.dart';
import 'package:flow_editor/core/controller/impl/edge_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/node_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/selection_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/viewport_controller_impl.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 把“低级行为”（Behavior 层）和“高层命令”都放到一起的统一 Controller
class CanvasController implements ICanvasController {
  final CommandManager _cmd;
  final NodeControllerImpl _nodeCtrl;
  final EdgeControllerImpl _edgeCtrl;
  final ViewportControllerImpl _vpCtrl;
  final SelectionControllerImpl _selCtrl;
  final CommandContext _ctx;

  CanvasController(this._ctx)
      : _cmd = CommandManager(_ctx),
        _nodeCtrl = NodeControllerImpl(_ctx),
        _edgeCtrl = EdgeControllerImpl(_ctx),
        _vpCtrl = ViewportControllerImpl(_ctx),
        _selCtrl = SelectionControllerImpl(_ctx);

  EditorState get _st => _ctx.getState();
  set _st(EditorState s) => _ctx.updateState(s);

  // ---------------------------------------------------
  // === 低级画布操作：更新 InteractionState  ===
  // ---------------------------------------------------

  @override
  void startNodeDrag(String nodeId) {
    _st = _st.copyWith(
      interaction: InteractionState.dragNode(
        nodeId: nodeId,
        lastCanvas: Offset.zero,
      ),
    );
  }

  @override
  void updateNodeDrag(Offset delta) {
    final it = _st.interaction;
    if (it is DragNode) {
      _st = _st.copyWith(
        interaction: it.copyWith(lastCanvas: it.lastCanvas + delta),
      );
    }
  }

  @override
  void endNodeDrag() {
    _st = _st.copyWith(interaction: const InteractionState.idle());
  }

  @override
  void startEdgeDrag(String anchorId) {
    // 生成一个临时 edgeId
    final tempEdgeId =
        'temp_edge_${anchorId}_${DateTime.now().millisecondsSinceEpoch}';
    // 找到对应 AnchorModel
    final node = _st.nodeState.nodes
        .firstWhere((n) => n.id == anchorId.split('_').first);
    final anchor = node.anchors.firstWhere((a) => a.id == anchorId);
    _st = _st.copyWith(
      interaction: InteractionState.dragEdge(
        edgeId: tempEdgeId,
        lastCanvas: Offset.zero,
        sourceAnchor: anchor,
      ),
    );
  }

  @override
  void updateEdgeDrag(Offset canvasPos) {
    final it = _st.interaction;
    if (it is DragEdge) {
      _st = _st.copyWith(
        interaction: it.copyWith(lastCanvas: canvasPos),
      );
    }
  }

  @override
  void endEdgeDrag({String? targetNodeId, String? targetAnchorId}) {
    // 结束时，如果希望自动新增一条真正的边，可以在这里：
    // if (targetNodeId != null && targetAnchorId != null) {
    //   _edgeCtrl.addEdge(EdgeModel.generated(...));
    // }
    _st = _st.copyWith(interaction: const InteractionState.idle());
  }

  @override
  void marqueeSelect(Rect area) {
    _st = _st.copyWith(
      interaction: InteractionState.selectingArea(selectionBox: area),
    );
  }

  @override
  void deleteSelection() {
    // 高层命令会实际删除，此处不变动临时 state
  }

  @override
  void copySelection() {
    // 同上
  }

  @override
  void pasteClipboard() {
    // 同上
  }

  @override
  void panBy(Offset delta) {
    final it = _st.interaction;
    if (it is PanCanvas) {
      _st = _st.copyWith(
        interaction: it.copyWith(lastGlobal: it.lastGlobal + delta),
      );
    } else {
      _st = _st.copyWith(
        interaction: InteractionState.panCanvas(lastGlobal: delta),
      );
    }
    // 同时更新视口状态
    _vpCtrl.panBy(delta);
  }

  @override
  void zoomAt(Offset focalPoint, double scaleDelta) {
    // Behavior 层不更新 InteractionState，仅更新视口
    _vpCtrl.zoomAt(focalPoint, scaleDelta);
  }

  @override
  void undo() => _cmd.undo();

  @override
  void redo() => _cmd.redo();

  // ---------------------------------------------------
  // === 高层命令：委托给 ICommand 实现层  ===
  // ---------------------------------------------------

  @override
  Future<void> addNode(NodeModel node) => _nodeCtrl.addNode(node);

  @override
  Future<void> deleteNode(String nodeId) => _nodeCtrl.deleteNode(nodeId);

  @override
  Future<void> deleteNodeWithEdges(String nodeId) =>
      _nodeCtrl.deleteNodeWithEdges(nodeId);

  @override
  Future<void> moveNode(String nodeId, Offset to) =>
      _nodeCtrl.moveNode(nodeId, to);

  @override
  Future<void> updateNodeProperty(
          String nodeId, NodeModel Function(NodeModel) updateFn) =>
      _nodeCtrl.updateNodeProperty(nodeId, updateFn);

  @override
  Future<void> groupNodes(List<String> nodeIds) =>
      _nodeCtrl.groupNodes(nodeIds);

  @override
  Future<void> ungroupNodes(String groupId) => _nodeCtrl.ungroupNodes(groupId);

  @override
  Future<void> addEdge(EdgeModel edge) => _edgeCtrl.addEdge(edge);

  @override
  Future<void> deleteEdge(String edgeId) => _edgeCtrl.deleteEdge(edgeId);

  @override
  Future<void> moveEdge(String edgeId, Offset from, Offset to) =>
      _edgeCtrl.moveEdge(edgeId, from, to);

  @override
  Future<void> updateEdgeProperty(
          String edgeId, EdgeModel Function(EdgeModel) updateFn) =>
      _edgeCtrl.updateEdgeProperty(edgeId, updateFn);

  @override
  Future<void> selectNodes(Set<String> nodeIds) =>
      _selCtrl.selectNodes(nodeIds);

  @override
  Future<void> selectEdges(Set<String> edgeIds) =>
      _selCtrl.selectEdges(edgeIds);

  @override
  Future<void> clearSelection() => _selCtrl.clearSelection();

  @override
  String generateTempEdgeId(AnchorModel sourceAnchor) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return 'temp_edge_${sourceAnchor.nodeId}_${sourceAnchor.id}_$now';
  }
}
