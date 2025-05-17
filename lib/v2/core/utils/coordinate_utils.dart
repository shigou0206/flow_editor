// lib/core/utils/coordinate_utils.dart

import 'package:flutter/material.dart';

/// 坐标转换工具：支持画布交互以及节点/子图嵌套场景
class CoordinateUtils {
  /// 全局(global)坐标 → 本地(local)坐标
  static Offset globalToLocal(RenderBox box, Offset globalPos) =>
      box.globalToLocal(globalPos);

  /// 本地(local)坐标 → 世界(world)坐标（画布交互场景）
  static Offset localToWorld(Offset localPos, Offset pan, double scale) =>
      (localPos - pan) / scale;

  /// 世界(world)坐标 → 本地(local)坐标（画布交互场景）
  static Offset worldToLocal(Offset worldPos, Offset pan, double scale) =>
      worldPos * scale + pan;

  /// 全局(global)坐标 → 世界(world)坐标
  static Offset globalToWorld(
    RenderBox box,
    Offset globalPos,
    Offset pan,
    double scale,
  ) {
    final local = globalToLocal(box, globalPos);
    return localToWorld(local, pan, scale);
  }

  /// 本地(local)坐标 → 全局(global)坐标
  static Offset localToGlobal(RenderBox box, Offset localPos) =>
      box.localToGlobal(localPos);

  /// 世界(world)坐标 → 全局(global)坐标
  static Offset worldToGlobal(
    RenderBox box,
    Offset worldPos,
    Offset pan,
    double scale,
  ) {
    final local = worldToLocal(worldPos, pan, scale);
    return localToGlobal(box, local);
  }

  /// 将子节点的本地 (relative) 坐标映射到父级的世界 (absolute) 坐标
  ///
  /// 例如 B 在 A 内部时：
  ///   worldB = childLocalToParentWorld(B.localPos, A.worldPos, A.scale)
  static Offset childLocalToParentWorld(
    Offset childLocalPos,
    Offset parentWorldPos,
    double parentScale,
  ) {
    return parentWorldPos + childLocalPos * parentScale;
  }

  /// 将父级的世界 (absolute) 坐标反向映射回子节点的本地 (relative) 坐标
  ///
  /// 例如已知 worldB，算回 B.localPos：
  ///   localB = parentWorldToChildLocal(worldB, A.worldPos, A.scale)
  static Offset parentWorldToChildLocal(
    Offset childWorldPos,
    Offset parentWorldPos,
    double parentScale,
  ) {
    return (childWorldPos - parentWorldPos) / parentScale;
  }

  /// 多级嵌套：本地(local)坐标 → 世界(world)坐标
  ///
  /// [origins] 和 [scales] 数组按从内到外（child→parent→…）顺序提供
  /// 例如对于 D 在 C→B→A 嵌套：
  ///   origins = [C.worldPos, B.worldPos, A.worldPos]
  ///   scales  = [C.scale,    B.scale,    A.scale]
  static Offset nestedLocalToWorld(
    Offset localPos,
    List<Offset> origins,
    List<double> scales,
  ) {
    assert(origins.length == scales.length);
    var p = localPos;
    for (var i = 0; i < origins.length; i++) {
      p = origins[i] + p * scales[i];
    }
    return p;
  }

  /// 多级嵌套：世界(world)坐标 → 本地(local)坐标
  ///
  /// 将最外层世界坐标逆序映射回最内层本地坐标
  static Offset nestedWorldToLocal(
    Offset worldPos,
    List<Offset> origins,
    List<double> scales,
  ) {
    assert(origins.length == scales.length);
    var p = worldPos;
    for (var i = origins.length - 1; i >= 0; i--) {
      p = (p - origins[i]) / scales[i];
    }
    return p;
  }
}
