// core/command/exec/pan_canvas_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flutter/painting.dart';

/// 平移视口：将当前视口偏移量增加一个 delta
class PanCanvasCommand implements ICommand {
  final CommandContext ctx;
  final Offset delta;

  late final Offset _beforeOffset;

  PanCanvasCommand(this.ctx, this.delta);

  @override
  String get description => 'Pan canvas by $delta';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    _beforeOffset = st.viewport.offset;
    final newOffset = _beforeOffset + delta;
    ctx.updateState(st.copyWith(
      viewport: st.viewport.copyWith(offset: newOffset),
    ));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    ctx.updateState(st.copyWith(
      viewport: st.viewport.copyWith(offset: _beforeOffset),
    ));
  }
}
