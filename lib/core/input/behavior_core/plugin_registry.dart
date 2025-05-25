// core/input/behavior_core/plugin_registry.dart

import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/behavior_plugins/canvas_pan_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/canvas_zoom_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/node_hover_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/node_drag_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/edge_hover_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/edge_draw_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/marquee_select_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/delete_key_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/copy_paste_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/undo_redo_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/insert_node_preview_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/node_context_menu_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/node_select_behavior.dart';

List<CanvasBehavior> registerDefaultBehaviors(BehaviorContext context) {
  final behaviors = <CanvasBehavior>[
    CanvasPanBehavior(context),
    CanvasZoomBehavior(context),
    NodeHoverBehavior(context),
    NodeDragBehavior(context),
    NodeContextMenuBehavior(context),
    NodeSelectBehavior(context),
    EdgeHoverBehavior(context),
    EdgeDrawBehavior(context),
    InsertNodePreviewBehavior(context),
    MarqueeSelectBehavior(context),
    DeleteKeyBehavior(context),
    CopyPasteBehavior(context),
    UndoRedoBehavior(context),
  ];

  behaviors.sort((a, b) => a.priority.compareTo(b.priority));
  return behaviors;
}
