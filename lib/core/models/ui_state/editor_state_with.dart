import 'package:flow_editor/core/models/ui_state/editor_state.dart';

class EditorStateWith<T> {
  final String id; // ✅ 新增唯一标识符（如 workflowId）
  final EditorState ui;
  final T logic;

  const EditorStateWith({
    required this.id,
    required this.ui,
    required this.logic,
  });

  EditorStateWith<T> copyWith({
    String? id,
    EditorState? ui,
    T? logic,
  }) {
    return EditorStateWith(
      id: id ?? this.id,
      ui: ui ?? this.ui,
      logic: logic ?? this.logic,
    );
  }
}

extension EditorStateWithX<T> on EditorStateWith<T> {
  EditorState get editor => ui;
  T get data => logic;
  String get workflowId => id;
}
