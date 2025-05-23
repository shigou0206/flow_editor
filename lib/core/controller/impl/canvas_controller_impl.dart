// canvas_controller_impl.dart

import 'package:flow_editor/core/controller/interfaces/canvas_controller.dart';
import 'package:flow_editor/core/controller/interfaces/graph_controller.dart';
import 'package:flow_editor/core/controller/interfaces/interaction_controller.dart';
import 'package:flow_editor/core/controller/interfaces/viewport_controller.dart';

import 'package:flow_editor/core/controller/impl/graph_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/interaction_controller_impl.dart';
import 'package:flow_editor/core/controller/impl/viewport_controller_impl.dart';
import 'package:flow_editor/core/command/command_context.dart';

class CanvasControllerImpl implements ICanvasController {
  @override
  final IGraphController graph;

  @override
  final IInteractionController interaction;

  @override
  final IViewportController viewport;

  CanvasControllerImpl(CommandContext ctx)
      : graph = GraphControllerImpl(ctx),
        viewport = ViewportControllerImpl(ctx),
        interaction = InteractionControllerImpl(
          ctx: ctx,
        );
}
