// lib/core/utils/hit_test_utils.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/node_model.dart';

class HitTestUtils {
  /// 节点命中：判断 worldPos 是否落在 node.rect 内
  static bool hitTestNode(Offset worldPos, NodeModel node) {
    return node.rect.contains(worldPos);
  }

  /// 锚点命中：判断 worldPos 是否落在 anchor 的包围盒内
  /// [anchorPos] 是 world 坐标下的锚点中心位置
  static bool hitTestAnchor(
    Offset worldPos,
    Offset anchorPos,
    double width,
    double height, {
    double padding = 4.0,
  }) {
    final halfW = width / 2 + padding;
    final halfH = height / 2 + padding;
    final rect =
        Rect.fromCenter(center: anchorPos, width: halfW * 2, height: halfH * 2);
    return rect.contains(worldPos);
  }

  /// 计算点 P 到线段 AB 的最短距离
  static double distanceToSegment(Offset a, Offset b, Offset p) {
    final ab = b - a;
    final ap = p - a;
    final ab2 = ab.dx * ab.dx + ab.dy * ab.dy;
    if (ab2 == 0) return (p - a).distance;
    // 投影系数
    final t = (ap.dx * ab.dx + ap.dy * ab.dy) / ab2;
    if (t < 0.0) return (p - a).distance;
    if (t > 1.0) return (p - b).distance;
    final proj = Offset(a.dx + ab.dx * t, a.dy + ab.dy * t);
    return (p - proj).distance;
  }
}
