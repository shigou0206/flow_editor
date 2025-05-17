import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';

/// ───── 拖拽相关 ─────────────────────────────
final draggingNodeIdProvider = StateProvider<String?>((_) => null);
final dragStartPointProvider = StateProvider<Offset?>((_) => null);
final marqueeSelectionProvider = StateProvider<Rect?>((_) => null);

/// ───── 悬停相关 ─────────────────────────────
final hoveredNodeIdProvider = StateProvider<String?>((_) => null);
final hoveredAnchorIdProvider = StateProvider<String?>((_) => null);
final hoveredEdgeIdProvider = StateProvider<String?>((_) => null);

/// ───── 选择相关 ─────────────────────────────
final selectedNodesProvider = StateProvider<Set<String>>((_) => {});
final selectedEdgesProvider = StateProvider<Set<String>>((_) => {});

/// ───── 菜单/编辑面板 ─────────────────────────
final contextMenuTargetProvider = StateProvider<String?>((_) => null);
final editingTargetProvider = StateProvider<String?>((_) => null);

/// ───── 缩放/平移 手势 ─────────────────────────
final isPanningProvider = StateProvider<bool>((_) => false);
final pinchCenterProvider = StateProvider<Offset?>((_) => null);

/// ───── 剪贴板 ───────────────────────────────
final clipboardProvider = StateProvider<Map<String, List<String>>>(
  (_) => {'nodes': [], 'edges': []},
);

/// ───── 幽灵边（Ghost Edge） ───────────────────
final ghostEdgeProvider = StateProvider<EdgeModel?>((_) => null);

/// ───── 画布偏移与缩放 ─────────────────────────
final canvasOffsetProvider = StateProvider<Offset>((_) => Offset.zero);
final canvasScaleProvider = StateProvider<double>((_) => 1.0);
