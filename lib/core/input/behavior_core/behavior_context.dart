import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/controller/interfaces/canvas_controller.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

class BehaviorContext {
  final ICanvasController controller;
  final EditorState Function() getState;
  final void Function(EditorState) updateState;

  final CanvasHitTester hitTester;

  const BehaviorContext({
    required this.controller,
    required this.getState,
    required this.updateState,
    required this.hitTester,
  });

  InteractionState get interaction => getState().interaction;

  void updateInteraction(InteractionState newInteraction) {
    final current = getState();
    updateState(current.copyWith(interaction: newInteraction));
  }
}
