// anchor_resolver_impl.dart
import 'package:flutter/material.dart';
import 'package:flow_editor/core/utils/anchor_utils.dart';
import 'package:flow_editor/core/models/node_model.dart';

class AnchorResolver {
  AnchorResolver(this.allNodes);

  final List<NodeModel> allNodes;

  /// 满足 AnchorWorldResolver 签名
  Offset call(String nodeId, String? anchorId) {
    final node = allNodes.firstWhere((n) => n.id == nodeId);
    final anchor = (anchorId != null)
        ? node.anchors.firstWhere((a) => a.id == anchorId)
        : node.anchors.first; // 或者 node 默认中心 anchor
    return anchorWorldPosition(node, anchor, allNodes);
  }
}
