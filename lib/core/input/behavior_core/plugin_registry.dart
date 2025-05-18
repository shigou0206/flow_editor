import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/behavior_plugins/canvas_pan_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/canvas_zoom_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/node_drag_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/edge_draw_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/marquee_select_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/delete_key_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/copy_paste_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/undo_redo_behavior.dart';

import 'canvas_behavior.dart';

/// 注册所有默认行为插件
List<CanvasBehavior> registerDefaultBehaviors(BehaviorContext context) {
  return [
    CanvasPanBehavior(context),
    CanvasZoomBehavior(context),
    NodeDragBehavior(context),
    EdgeDrawBehavior(context),
    MarqueeSelectBehavior(context),
    DeleteKeyBehavior(context),
    CopyPasteBehavior(context),
    UndoRedoBehavior(context),
  ];
}
