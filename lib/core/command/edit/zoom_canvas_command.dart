import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flutter/painting.dart';

/// 缩放视口：以 focalPoint（视口坐标）为中心，按照 scaleDelta 缩放
class ZoomCanvasCommand implements ICommand {
  final CommandContext ctx;
  final Offset focalPoint;
  final double scaleDelta;

  late final Offset _beforeOffset;
  late final double _beforeScale;

  ZoomCanvasCommand(this.ctx, this.focalPoint, this.scaleDelta);

  @override
  String get description => 'Zoom canvas at $focalPoint by factor $scaleDelta';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    _beforeOffset = st.canvasState.offset;
    _beforeScale = st.canvasState.scale;

    final oldScale = _beforeScale;
    final newScale = oldScale * scaleDelta;

    // 将 focalPoint（视口坐标）转换到画布坐标：
    // canvasPoint = focalPoint / oldScale + offset
    final canvasPoint = focalPoint / oldScale + _beforeOffset;

    // 缩放后，为了让 canvasPoint 仍然落在 focalPoint 处，
    // 新的 offset 应该是：canvasPoint - focalPoint / newScale
    final newOffset = canvasPoint - focalPoint / newScale;

    ctx.updateState(st.copyWith(
      canvasState: st.canvasState.copyWith(
        offset: newOffset,
        scale: newScale,
      ),
    ));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    ctx.updateState(st.copyWith(
      canvasState: st.canvasState.copyWith(
        offset: _beforeOffset,
        scale: _beforeScale,
      ),
    ));
  }
}
