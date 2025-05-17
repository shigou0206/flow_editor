import 'package:flutter/material.dart';

/// CanvasViewportState 表示画布视口的状态
/// 包含偏移量、缩放比例和视口尺寸
class CanvasViewportState {
  /// 画布的偏移量，表示画布原点相对于视口左上角的位置
  final Offset offset;

  /// 画布的缩放比例
  final double scale;

  /// 视口的尺寸（可选）
  final Size? viewportSize;

  /// 构造函数
  const CanvasViewportState({
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.viewportSize,
  });

  /// 创建一个新的 CanvasViewportState 实例，可选择性地更新部分字段
  CanvasViewportState copyWith({
    Offset? offset,
    double? scale,
    Size? viewportSize,
  }) {
    return CanvasViewportState(
      offset: offset ?? this.offset,
      scale: scale ?? this.scale,
      viewportSize: viewportSize ?? this.viewportSize,
    );
  }

  /// 将视口坐标转换为画布坐标
  Offset viewportToCanvas(Offset viewportPoint) {
    return viewportPoint / scale + offset;
  }

  /// 将画布坐标转换为视口坐标
  Offset canvasToViewport(Offset canvasPoint) {
    return (canvasPoint - offset) * scale;
  }

  /// 判断画布上的点是否在视口内可见
  bool isPointVisible(Offset canvasPoint) {
    if (viewportSize == null) return true; // 如果没有视口尺寸，假设总是可见

    final viewportPoint = canvasToViewport(canvasPoint);
    return viewportPoint.dx >= 0 &&
        viewportPoint.dy >= 0 &&
        viewportPoint.dx <= viewportSize!.width &&
        viewportPoint.dy <= viewportSize!.height;
  }

  /// 判断画布上的矩形是否在视口内可见（全部或部分）
  bool isRectVisible(Rect canvasRect) {
    if (viewportSize == null) return true; // 如果没有视口尺寸，假设总是可见

    final viewportRect =
        Rect.fromLTWH(0, 0, viewportSize!.width, viewportSize!.height);
    final transformedRect = Rect.fromLTRB(
      (canvasRect.left - offset.dx) * scale,
      (canvasRect.top - offset.dy) * scale,
      (canvasRect.right - offset.dx) * scale,
      (canvasRect.bottom - offset.dy) * scale,
    );

    return viewportRect.overlaps(transformedRect);
  }

  /// 获取视口在画布上覆盖的矩形区域
  Rect get visibleCanvasRect {
    if (viewportSize == null) {
      return Rect.largest; // 如果没有视口尺寸，返回一个"无限大"的矩形
    }

    return Rect.fromLTWH(
      offset.dx,
      offset.dy,
      viewportSize!.width / scale,
      viewportSize!.height / scale,
    );
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson() => {
        'offsetX': offset.dx,
        'offsetY': offset.dy,
        'scale': scale,
        'viewportWidth': viewportSize?.width,
        'viewportHeight': viewportSize?.height,
      };

  /// 从 JSON 反序列化
  factory CanvasViewportState.fromJson(Map<String, dynamic> json) {
    final offsetX = (json['offsetX'] as num?)?.toDouble() ?? 0.0;
    final offsetY = (json['offsetY'] as num?)?.toDouble() ?? 0.0;
    final scale = (json['scale'] as num?)?.toDouble() ?? 1.0;

    Size? viewportSize;
    final viewportWidth = (json['viewportWidth'] as num?)?.toDouble();
    final viewportHeight = (json['viewportHeight'] as num?)?.toDouble();

    if (viewportWidth != null && viewportHeight != null) {
      viewportSize = Size(viewportWidth, viewportHeight);
    }

    return CanvasViewportState(
      offset: Offset(offsetX, offsetY),
      scale: scale,
      viewportSize: viewportSize,
    );
  }

  @override
  String toString() =>
      'CanvasViewportState(offset: $offset, scale: $scale, viewportSize: $viewportSize)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CanvasViewportState &&
        other.offset == offset &&
        other.scale == scale &&
        other.viewportSize == viewportSize;
  }

  @override
  int get hashCode => Object.hash(offset, scale, viewportSize);
}
