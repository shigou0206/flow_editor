// import 'package:flutter_test/flutter_test.dart';
// import 'package:flow_editor/core/command/command_context.dart';
// import 'package:flow_editor/core/input/controller/canvas_controller.dart';
// import 'package:flow_editor/core/models/state/canvas_state.dart';
// import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
// import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
// import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';

// void main() {
//   test('CommandContext forwards getState and updateState', () {
//     // initial state and controller
//     CanvasState state = const CanvasState(
//       interactionConfig: CanvasInteractionConfig(),
//       visualConfig: CanvasVisualConfig(),
//       interactionState: CanvasInteractionState(),
//     );
//     final ctrl = CanvasController();
//     final ctx = CommandContext(
//       controller: ctrl,
//       getState: () => state,
//       updateState: (s) => state = s,
//     );

//     // getState should return the same instance
//     expect(ctx.getState(), same(state));

//     // updateState should overwrite our local state
//     final newState = state.copyWith(scale: 2.5);
//     ctx.updateState(newState);
//     expect(state.scale, 2.5);
//     expect(ctx.getState(), same(newState));
//   });
// }
