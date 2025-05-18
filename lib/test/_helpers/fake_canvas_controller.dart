// test/_helpers/fake_canvas_controller.dart

import 'dart:ui';

import 'package:flow_editor/core/controller/canvas_controller_interface.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class FakeCanvasController implements ICanvasController {
  Offset? lastPanDelta;
  bool didCopy = false;
  bool didPaste = false;
  bool didDelete = false;
  bool didUndo = false;
  bool didRedo = false;
  String? startedAnchorId;
  Offset? lastPos;
  bool endCalled = false;
  Offset? lastFocal;
  double? lastDelta;
  Rect? lastRect;
  String? startedNodeId;
  Offset? dragDelta;
  @override
  Future<void> copySelection() async {
    didCopy = true;
  }

  @override
  Future<void> deleteSelection() async {
    didDelete = true;
  }

  @override
  Future<void> endEdgeDrag(
      {String? targetAnchorId, String? targetNodeId}) async {
    endCalled = true;
  }

  @override
  Future<void> marqueeSelect(Rect rect) async {
    lastRect = rect;
  }

  @override
  Future<void> pasteClipboard() async {
    didPaste = true;
  }

  @override
  Future<void> startEdgeDrag(String anchorId) async {
    startedAnchorId = anchorId;
  }

  @override
  Future<void> startNodeDrag(String nodeId) async {
    startedNodeId = nodeId;
  }

  @override
  Future<void> updateEdgeDrag(Offset pos) async {
    lastPos = pos;
  }

  @override
  Future<void> updateNodeDrag(Offset delta) async {
    dragDelta = delta;
  }

  @override
  Future<void> endNodeDrag() async {
    endCalled = true;
  }

  @override
  Future<void> addNode(NodeModel _) async {}
  @override
  Future<void> deleteNode(String _) async {}
  @override
  Future<void> deleteNodeWithEdges(String _) async {}
  @override
  Future<void> moveNode(String _, Offset __) async {}
  @override
  Future<void> updateNodeProperty(String _, fn) async {}
  @override
  Future<void> groupNodes(List<String> _) async {}
  @override
  Future<void> ungroupNodes(String _) async {}

  @override
  Future<void> addEdge(EdgeModel _) async {}
  @override
  Future<void> deleteEdge(String _) async {}
  @override
  Future<void> moveEdge(String _, Offset __, Offset ___) async {}
  @override
  Future<void> updateEdgeProperty(String _, fn) async {}

  @override
  void panBy(Offset delta) {
    lastPanDelta = delta;
  }

  @override
  Future<void> zoomAt(Offset focal, double delta) async {
    lastFocal = focal;
    lastDelta = delta;
  }

  @override
  Future<void> selectNodes(Set<String> _) async {}
  @override
  Future<void> selectEdges(Set<String> _) async {}
  @override
  Future<void> clearSelection() async {}

  @override
  void undo() {
    didUndo = true;
  }

  @override
  void redo() {
    didRedo = true;
  }

  @override
  Future<void> runNode(String _, {data}) async {}
  @override
  Future<void> stopNode(String _, {data}) async {}
  @override
  Future<void> failNode(String _, {data}) async {}
  @override
  Future<void> completeNode(String _, {data}) async {}
  @override
  Future<void> runWorkflow({data}) async {}
  @override
  Future<void> cancelWorkflow({data}) async {}
  @override
  Future<void> failWorkflow({data}) async {}
  @override
  Future<void> completeWorkflow({data}) async {}
}
