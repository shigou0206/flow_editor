// implementations/viewport_controller_impl.dart

import 'dart:ui';
import 'package:flow_editor/core/controller/interfaces/viewport_controller.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/edit/pan_canvas_command.dart';
import 'package:flow_editor/core/command/edit/zoom_canvas_command.dart';

class ViewportControllerImpl implements IViewportController {
  final CommandContext _ctx;
  final CommandManager _cmdMgr;

  ViewportControllerImpl(this._ctx) : _cmdMgr = CommandManager(_ctx);

  @override
  void panBy(Offset delta) {
    _cmdMgr.executeCommand(PanCanvasCommand(_ctx, delta));
  }

  @override
  void panTo(Offset position) {
    final currentOffset = _ctx.getState().canvasState.offset;
    final delta = position - currentOffset;
    panBy(delta);
  }

  @override
  void zoomAt(Offset focalPoint, double scaleDelta) {
    _cmdMgr.executeCommand(ZoomCanvasCommand(_ctx, focalPoint, scaleDelta));
  }

  @override
  void zoomTo(double scale) {
    final currentScale = _ctx.getState().canvasState.scale;
    final scaleDelta = scale / currentScale;
    zoomAt(Offset.zero, scaleDelta);
  }

  @override
  void focusOnPosition(Offset position) {
    panTo(position);
  }
}
