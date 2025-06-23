import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';

part 'clipboard_state.freezed.dart';
part 'clipboard_state.g.dart';

@freezed
class ClipboardState with _$ClipboardState {
  const factory ClipboardState({
    @Default([]) List<NodeModel> nodes,
    @Default([]) List<EdgeModel> edges,
  }) = _ClipboardState;

  factory ClipboardState.fromJson(Map<String, dynamic> json) =>
      _$ClipboardStateFromJson(json);
}
