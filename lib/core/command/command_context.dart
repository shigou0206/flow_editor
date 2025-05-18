// lib/core/command/command_context.dart

import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/core/controller/canvas_controller_interface.dart';

/// Provides commands with everything they need to read & mutate
/// the global EditorState, as well as issue canvas‐level actions.
class CommandContext {
  /// Gives access to low‐level canvas operations (pan, zoom, etc).
  final ICanvasController controller;

  /// Reads the current full editor state.
  final EditorState Function() getState;

  /// Writes a new full editor state.
  final void Function(EditorState) updateState;

  const CommandContext({
    required this.controller,
    required this.getState,
    required this.updateState,
  });
}
