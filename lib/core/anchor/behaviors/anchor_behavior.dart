import 'package:flutter/material.dart';
import '../models/anchor_model.dart';

/// AnchorBehavior：定义锚点(Anchor)的各类交互回调。
/// 当用户与锚点进行点击/拖拽/右键/悬停等操作时，外部逻辑(如EdgeState/NodeState)可在这里进行处理。
abstract class AnchorBehavior {
  /// 当用户单击锚点
  void onAnchorTap(AnchorModel anchor) {}

  /// 当用户双击锚点
  void onAnchorDoubleTap(AnchorModel anchor) {}

  /// 当鼠标悬停进出锚点区域时
  /// [isHover] = true => 鼠标进入; false => 鼠标离开
  void onAnchorHover(AnchorModel anchor, bool isHover) {}

  /// 当用户在锚点上触发右键菜单 (上下文菜单)
  /// [localPos] 为事件触发时的局部坐标(可根据需求转换为世界坐标)
  void onAnchorContextMenu(AnchorModel anchor, Offset localPos) {}

  /// 当用户**开始拖拽**锚点（按下后移动）
  /// [startPos] 通常是事件发生时的**世界坐标**(或画布坐标)，以便后续连线
  void onAnchorDragStart(AnchorModel anchor, Offset startPos) {}

  /// 当用户**正在拖拽**锚点
  /// [currentPos] 为当前鼠标(或手指)的**世界坐标**，
  /// 用于更新 ghost line 的终点等
  void onAnchorDragUpdate(AnchorModel anchor, Offset currentPos) {}

  /// 当用户**结束拖拽**锚点(松开鼠标/手指)
  /// [endPos] 为松开时的**世界坐标**，可做 hitTest 判断是否落在他处锚点
  /// [canceled] 若为 true，表示拖拽被取消(比如按Esc或其它方式退出)
  void onAnchorDragEnd(
    AnchorModel anchor,
    Offset endPos, {
    bool canceled = false,
  }) {}
}
