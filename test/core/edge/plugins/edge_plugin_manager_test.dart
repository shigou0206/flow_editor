import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/edge/plugins/edge_plugin_manager.dart';
import 'package:flow_editor/core/edge/plugins/edge_plugin.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

class MockEdgePlugin extends EdgePlugin {
  final List<String> events = [];

  @override
  void onEdgeCreated(EdgeModel edge) => events.add('created:${edge.id}');

  @override
  void onEdgeDeleted(EdgeModel edge) => events.add('deleted:${edge.id}');

  @override
  void onEdgeUpdated(EdgeModel oldEdge, EdgeModel newEdge) =>
      events.add('updated:${oldEdge.id}->${newEdge.id}');

  @override
  void onEdgeSelected(EdgeModel edge) => events.add('selected:${edge.id}');

  @override
  void onEdgeDeselected(EdgeModel edge) => events.add('deselected:${edge.id}');
}

void main() {
  group('EdgePluginManager Tests', () {
    late EdgePluginManager pluginManager;
    late MockEdgePlugin pluginA;
    late MockEdgePlugin pluginB;

    final testEdge1 = EdgeModel(
      id: 'edge1',
      sourceNodeId: 'nodeA',
      sourceAnchorId: 'aA',
    );
    final testEdge2 = EdgeModel(
      id: 'edge2',
      sourceNodeId: 'nodeB',
      sourceAnchorId: 'aB',
    );

    setUp(() {
      pluginManager = EdgePluginManager();
      pluginA = MockEdgePlugin();
      pluginB = MockEdgePlugin();
    });

    test('should register plugins correctly', () {
      pluginManager.registerPlugin(pluginA);
      pluginManager.registerPlugin(pluginB);

      expect(pluginManager.pluginCount, 2);
    });

    test('should unregister plugin correctly', () {
      pluginManager.registerPlugin(pluginA);
      pluginManager.registerPlugin(pluginB);
      pluginManager.unregisterPlugin(pluginA);

      expect(pluginManager.pluginCount, 1);
    });

    test('should notify plugins on edge creation', () {
      pluginManager.registerPlugin(pluginA);
      pluginManager.registerPlugin(pluginB);

      pluginManager.notifyEdgeCreated(testEdge1);

      expect(pluginA.events, ['created:edge1']);
      expect(pluginB.events, ['created:edge1']);
    });

    test('should notify plugins on edge deletion', () {
      pluginManager.registerPlugin(pluginA);
      pluginManager.registerPlugin(pluginB);

      pluginManager.notifyEdgeDeleted(testEdge1);

      expect(pluginA.events, ['deleted:edge1']);
      expect(pluginB.events, ['deleted:edge1']);
    });

    test('should notify plugins on edge updated', () {
      pluginManager.registerPlugin(pluginA);

      pluginManager.notifyEdgeUpdated(testEdge1, testEdge2);

      expect(pluginA.events, ['updated:edge1->edge2']);
    });

    test('should notify plugins on edge selected', () {
      pluginManager.registerPlugin(pluginA);

      pluginManager.notifyEdgeSelected(testEdge1);

      expect(pluginA.events, ['selected:edge1']);
    });

    test('should notify plugins on edge deselected', () {
      pluginManager.registerPlugin(pluginA);

      pluginManager.notifyEdgeDeselected(testEdge1);

      expect(pluginA.events, ['deselected:edge1']);
    });

    test('should clear plugins correctly', () {
      pluginManager.registerPlugin(pluginA);
      pluginManager.registerPlugin(pluginB);
      pluginManager.clearPlugins();

      expect(pluginManager.pluginCount, 0);
    });

    test('should handle duplicate plugin registration gracefully', () {
      pluginManager.registerPlugin(pluginA);
      pluginManager.registerPlugin(pluginA); // Duplicate

      expect(pluginManager.pluginCount, 1);
    });
  });
}
