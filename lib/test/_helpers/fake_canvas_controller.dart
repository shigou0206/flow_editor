// test/_helpers/fake_canvas_controller.dart

import 'package:flow_editor/core/controller/canvas_controller_interface.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class FakeCanvasController implements ICanvasController {
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
  Future<void> panBy(Offset _) async {}
  @override
  Future<void> zoomAt(Offset __, double ___) async {}

  @override
  Future<void> selectNodes(Set<String> _) async {}
  @override
  Future<void> selectEdges(Set<String> _) async {}
  @override
  Future<void> clearSelection() async {}

  @override
  void undo() {}
  @override
  void redo() {}

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
