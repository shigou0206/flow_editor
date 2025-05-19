import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/state_store/providers.dart';
import 'package:flow_editor/core/state_management/state_store/editor_store_notifier.dart';

void main() {
  test('editorStoreProvider supplies an EditorStoreNotifier', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(editorStoreProvider.notifier);
    expect(notifier, isA<EditorStoreNotifier>());
  });

  test('default initial EditorState has expected structure', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final state = container.read(editorStoreProvider);
    expect(state.canvases, isNotEmpty);
    expect(state.activeWorkflowId, isNotEmpty);
    expect(state.nodes, isNotNull);
    expect(state.edges, isNotNull);
    expect(state.viewport, isNotNull);
  });
}
