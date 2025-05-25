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
    final currentScale = _ctx.getState().canvasState.scale;
    final newScale = (currentScale * scaleDelta).clamp(0.1, 10.0);
    final adjustedScaleDelta = newScale / currentScale;

    _cmdMgr.executeCommand(
      ZoomCanvasCommand(_ctx, focalPoint, adjustedScaleDelta),
    );
  }

  @override
  void zoomTo(double scale) {
    final safeScale = scale.clamp(0.1, 10.0);
    final currentScale = _ctx.getState().canvasState.scale;
    final scaleDelta = safeScale / currentScale;

    // 以当前视图中心作为缩放焦点，而非Offset.zero
    final canvasSize = _ctx.getState().canvasState.viewportSize;
    final focalPoint = Offset(canvasSize!.width / 2, canvasSize.height / 2);

    zoomAt(focalPoint, scaleDelta);
  }

  @override
  void focusOnPosition(Offset position) {
    final canvasSize = _ctx.getState().canvasState.viewportSize;
    final viewportCenter = Offset(canvasSize!.width / 2, canvasSize.height / 2);
    panTo(viewportCenter - position);
  }
}
