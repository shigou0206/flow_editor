import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';

void main() {
  test('CommandContext preserves controller and delegates state', () {
    // 用一个简单的 EditorState 作测试数据
    var holder = const EditorState(
      canvases: {'w': CanvasState()},
      activeWorkflowId: 'w',
      nodes: NodeState(),
      edges: EdgeState(),
      viewport: CanvasViewportState(),
    );

    // 1) 构造 context 时传入 FakeCanvasController

    final ctx = CommandContext(
      getState: () => holder,
      updateState: (newState) {
        holder = newState;
      },
    );

    // getState 取到的应该就是当前 holder
    expect(ctx.getState(), equals(holder));

    // 2) 调用 updateState 应该能修改外部 holder
    final modified = holder.copyWith(activeWorkflowId: 'newWF');
    ctx.updateState(modified);
    expect(holder.activeWorkflowId, equals('newWF'));

    // 3) 再次 getState 应该反映出新的 holder
    expect(ctx.getState().activeWorkflowId, equals('newWF'));
  });
}
