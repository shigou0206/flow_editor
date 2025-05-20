import 'package:flow_editor/core/models/state/editor_state.dart';

/// Provides commands with everything they need to read & mutate
/// the global EditorState, as well as issue canvas‐level actions.
class CommandContext {
  /// Reads the current full editor state.
  final EditorState Function() getState;

  /// Writes a new full editor state.
  final void Function(EditorState) updateState;

  const CommandContext({
    required this.getState,
    required this.updateState,
  });
}
