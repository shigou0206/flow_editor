import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/edge_model.dart';

/// 保存一层坐标空间的平移 / 缩放以及其父级信息
class SpaceTransform {
  SpaceTransform({
    required this.coordSpace,
    required this.pan,
    required this.scale,
    this.parentSpace = CoordSpace.world,
    this.parentId,
  });

  CoordSpace coordSpace; // 本层空间类型
  Offset pan; // 本层平移（local → parent）
  double scale; // 本层缩放（local → parent）
  CoordSpace parentSpace; // 父级空间类型
  String? parentId; // 父级 id（workflowId / groupNodeId）
}

/// 负责把任意 Edge 坐标空间下的点转换到 world 坐标。
/// 用法：在加载 / 更新工作流或 group 时，调用 [register] 更新对应 pan & scale。
class TransformService {
  /// key = workflowId / groupNodeId
  final Map<String, SpaceTransform> _registry = {};

  // 注册 / 更新 一层变换
  void register({
    required String id,
    required CoordSpace space,
    required Offset pan,
    required double scale,
    CoordSpace parentSpace = CoordSpace.world,
    String? parentId,
  }) {
    _registry[id] = SpaceTransform(
      coordSpace: space,
      pan: pan,
      scale: scale,
      parentSpace: parentSpace,
      parentId: parentId,
    );
  }

  /// 将 [local] （处于 [space]/[parentId]）转换到 world
  Offset toWorld(Offset local, CoordSpace space, String? parentId) {
    var p = local;
    var curSpace = space;
    var curId = parentId;

    // 逐层向上，直到 world
    while (curSpace != CoordSpace.world) {
      final info = _registry[curId];
      if (info == null) break; // 缺失登记时直接跳出，返回当前坐标
      // local → parent: 先平移再缩放
      p = (p - info.pan) / info.scale;
      curSpace = info.parentSpace;
      curId = info.parentId;
    }
    return p; // 现在是 world 坐标
  }
}
