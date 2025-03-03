// lib/core/edge/plugins/logger_edge_plugin.dart
import 'package:flow_editor/core/edge/plugins/edge_plugin.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

class LoggerEdgePlugin extends EdgePlugin {
  @override
  void onEdgeCreated(EdgeModel edge) {
    print('🔔 Edge created: ${edge.id}');
  }

  @override
  void onEdgeDeleted(EdgeModel edge) {
    print('🗑️ Edge deleted: ${edge.id}');
  }

  @override
  void onEdgeUpdated(EdgeModel oldEdge, EdgeModel newEdge) {
    print('🔄 Edge updated: ${oldEdge.id}');
  }

  @override
  void onEdgeSelected(EdgeModel edge) {
    print('✅ Edge selected: ${edge.id}');
  }

  @override
  void onEdgeDeselected(EdgeModel edge) {
    print('❌ Edge deselected: ${edge.id}');
  }
}
