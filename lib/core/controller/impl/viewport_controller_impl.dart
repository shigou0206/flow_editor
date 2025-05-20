import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/edit/pan_canvas_command.dart';
import 'package:flow_editor/core/command/edit/zoom_canvas_command.dart';
import 'package:flow_editor/core/controller/viewport_controller_interface.dart';

class ViewportControllerImpl implements IViewportController {
  final CommandContext _ctx;
  final CommandManager _commandManager;

  ViewportControllerImpl(this._ctx) : _commandManager = CommandManager(_ctx);

  @override
  Future<void> panBy(Offset delta) {
    return _commandManager.executeCommand(
      PanCanvasCommand(_ctx, delta),
    );
  }

  @override
  Future<void> zoomAt(Offset focalPoint, double scaleDelta) {
    return _commandManager.executeCommand(
      ZoomCanvasCommand(_ctx, focalPoint, scaleDelta),
    );
  }
}
