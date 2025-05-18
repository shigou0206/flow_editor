import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/controller/canvas_controller_interface.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

class BehaviorContext {
  final ICanvasController controller;
  final CanvasState Function() getState;
  final void Function(CanvasState) updateState;

  final CanvasHitTester hitTester;

  const BehaviorContext({
    required this.controller,
    required this.getState,
    required this.updateState,
    required this.hitTester,
  });

  CanvasInteractionState get interaction => getState().interactionState;

  void updateInteraction(CanvasInteractionState newInteraction) {
    final current = getState();
    updateState(current.copyWith(interactionState: newInteraction));
  }
}
