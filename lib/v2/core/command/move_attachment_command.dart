// // lib/flow_editor/core/command/move_attachment_command.dart
// import 'dart:ui';
// import 'command.dart';
// import 'command_bus.dart';
// import 'package:flow_editor/core/cache/cache_manager.dart';
// import 'package:flow_editor/core/models/edge_model.dart';
// import 'package:flow_editor/core/state/edge_state_notifier.dart'; // 依你的实现路径调整

// class MoveAttachmentCommand implements UndoableCommand {
//   MoveAttachmentCommand(this.edgeId, this.attId, this.delta);

//   final String edgeId;
//   final String attId;
//   final Offset delta;

//   late Offset _oldOffset;

//   @override
//   CommandType get type => CommandType.moveAttachment;

//   // ---------------- execute ----------------
//   @override
//   void execute() {
//     final notifier = EdgeStateNotifier.of(edgeId); // 自行实现获取
//     final edge = notifier.edge;
//     final idx = edge.attachments.indexWhere((a) => a.id == attId);

//     _oldOffset = edge.attachments[idx].offset;

//     final updatedAtt =
//         edge.attachments[idx].copyWith(offset: _oldOffset + delta);
//     final newList = [...edge.attachments]..[idx] = updatedAtt;

//     final newEdge = edge.copyWith(attachments: newList);
//     notifier.updateEdge(newEdge);

//     // 刷 Path & 附件缓存
//     final path = CacheManager.gm.edgePath(edgeId)!;
//     CacheManager.gm.refreshAttachmentCache(edgeId, path, newEdge, notify: true);
//   }

//   // ---------------- undo / redo ----------------
//   @override
//   void undo() {
//     final notifier = EdgeStateNotifier.of(edgeId);
//     final edge = notifier.edge;
//     final idx = edge.attachments.indexWhere((a) => a.id == attId);

//     final revertedAtt = edge.attachments[idx].copyWith(offset: _oldOffset);
//     final newList = [...edge.attachments]..[idx] = revertedAtt;

//     final newEdge = edge.copyWith(attachments: newList);
//     notifier.updateEdge(newEdge);

//     final path = CacheManager.gm.edgePath(edgeId)!;
//     CacheManager.gm.refreshAttachmentCache(edgeId, path, newEdge);
//   }

//   @override
//   void redo() => execute();
// }
