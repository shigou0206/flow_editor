import 'package:flow_editor/core/controller/interfaces/graph_controller.dart';
import 'package:flow_editor/core/controller/interfaces/interaction_controller.dart';
import 'package:flow_editor/core/controller/interfaces/viewport_controller.dart';

abstract class ICanvasController {
  IGraphController get graph;
  IInteractionController get interaction;
  IViewportController get viewport;
}
