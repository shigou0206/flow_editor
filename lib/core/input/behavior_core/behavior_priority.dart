import 'package:freezed_annotation/freezed_annotation.dart';

part 'behavior_priority.freezed.dart';
part 'behavior_priority.g.dart';

@freezed
class BehaviorPriority with _$BehaviorPriority {
  const factory BehaviorPriority({
    @Default(5) int anchorHover,
    @Default(6) int nodeHover,
    @Default(7) int edgeHover,
    @Default(10) int nodeDrag,
    @Default(20) int edgeDraw,
    @Default(30) int marqueeSelect,
    @Default(40) int resizeNode,
    @Default(50) int canvasPan,
    @Default(60) int canvasZoom,
    @Default(100) int deleteKey,
    @Default(110) int copyPasteKey,
    @Default(120) int undoRedoKey,
  }) = _BehaviorPriority;

  factory BehaviorPriority.fromJson(Map<String, dynamic> json) =>
      _$BehaviorPriorityFromJson(json);
}
