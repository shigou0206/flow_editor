import 'dart:ui';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/node_model.dart';

EdgeModel makeEdge({String id = 'e1'}) =>
    EdgeModel(id: id, start: Offset.zero, end: const Offset(10, 0));

NodeModel makeNode({String id = 'n1'}) =>
    NodeModel(id: id, position: Offset.zero, size: const Size(100, 100));
