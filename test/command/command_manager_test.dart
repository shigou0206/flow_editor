// // test/command/command_manager_test.dart

// import 'dart:ui';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:flow_editor/core/command/command_context.dart';
// import 'package:flow_editor/core/command/command_manager.dart';
// import 'package:flow_editor/core/command/i_command.dart';
// import 'package:flow_editor/core/input/controller/canvas_controller.dart';
// import 'package:flow_editor/core/models/state/canvas_state.dart';
// import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
// import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
// import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';

// /// 测试用：将 interactionState.marqueeRect.width 当作 counter，加一
// class IncrementCommand implements ICommand {
//   final CommandContext ctx;
//   int before = 0;

//   IncrementCommand(this.ctx);

//   @override
//   String get description => 'increment';

//   @override
//   Future<void> execute() async {
//     final st = ctx.getState();
//     final currentRect = st.interactionState.marqueeRect;
//     before = currentRect != null ? currentRect.width.toInt() : 0;

//     final newRect = Rect.fromLTWH(0, 0, (before + 1).toDouble(), 0);
//     final updated = st.copyWith(
//       interactionState: st.interactionState.copyWith(
//         marqueeRect: newRect,
//       ),
//     );
//     ctx.updateState(updated);
//   }

//   @override
//   Future<void> undo() async {
//     final st = ctx.getState();
//     final undoRect = Rect.fromLTWH(0, 0, before.toDouble(), 0);
//     ctx.updateState(
//       st.copyWith(
//         interactionState: st.interactionState.copyWith(
//           marqueeRect: undoRect,
//         ),
//       ),
//     );
//   }
// }

// /// 测试用：一个执行时抛异常的“坏”命令
// class BadCommand implements ICommand {
//   @override
//   String get description => 'bad';

//   @override
//   Future<void> execute() async {
//     throw Exception('fail');
//   }

//   @override
//   Future<void> undo() async {
//     fail('undo should not be called on failed execute');
//   }
// }

// void main() {
//   late CommandContext ctx;
//   late CanvasState state;
//   late CommandManager mgr;

//   setUp(() {
//     state = const CanvasState(
//       interactionConfig: CanvasInteractionConfig(),
//       visualConfig: CanvasVisualConfig(),
//       interactionState: CanvasInteractionState(),
//     );
//     ctx = CommandContext(
//       controller: CanvasController(),
//       getState: () => state,
//       updateState: (s) => state = s,
//     );
//     mgr = CommandManager(ctx);
//   });

//   test('initially cannot undo/redo', () {
//     expect(mgr.canUndo, isFalse);
//     expect(mgr.canRedo, isFalse);
//   });

//   test('executeCommand pushes onto undo stack and updates state', () async {
//     final cmd = IncrementCommand(ctx);
//     await mgr.executeCommand(cmd);
//     expect(mgr.canUndo, isTrue);
//     expect(mgr.canRedo, isFalse);
//     expect(state.interactionState.marqueeRect!.width, equals(1.0));
//   });

//   test('undo reverts state and enables redo', () async {
//     final cmd = IncrementCommand(ctx);
//     await mgr.executeCommand(cmd);
//     await mgr.undo();
//     expect(state.interactionState.marqueeRect!.width, equals(0.0));
//     expect(mgr.canRedo, isTrue);
//     expect(mgr.canUndo, isFalse);
//   });

//   test('redo reapplies command', () async {
//     final cmd = IncrementCommand(ctx);
//     await mgr.executeCommand(cmd);
//     await mgr.undo();
//     await mgr.redo();
//     expect(state.interactionState.marqueeRect!.width, equals(1.0));
//     expect(mgr.canUndo, isTrue);
//     expect(mgr.canRedo, isFalse);
//   });

//   test('clearHistory resets undo/redo stacks', () async {
//     await mgr.executeCommand(IncrementCommand(ctx));
//     await mgr.executeCommand(IncrementCommand(ctx));
//     mgr.clearHistory();
//     expect(mgr.canUndo, isFalse);
//     expect(mgr.canRedo, isFalse);
//   });

//   test('failed execute does not push to history', () async {
//     // 直接测试 BadCommand
//     await expectLater(
//       mgr.executeCommand(BadCommand()),
//       throwsException,
//     );
//     expect(mgr.canUndo, isFalse);
//     expect(mgr.canRedo, isFalse);
//   });
// }
