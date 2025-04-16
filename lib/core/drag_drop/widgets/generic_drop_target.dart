import 'package:flutter/material.dart';

/// 拖拽放置回调，传出拖拽数据和转换后的局部坐标（新版通用接口）
typedef OnDrop<T> = void Function(T data, Offset dropPosition);

/// 旧版：拖拽释放时传出拖拽数据和局部坐标
typedef OnAcceptWithPosition<T> = void Function(T data, Offset dropPosition);

/// 旧版：拖拽释放时仅传出拖拽数据
typedef OnAccept<T> = void Function(T data);

/// 全局坐标到局部坐标的转换回调
typedef TransformOffset = Offset Function(Offset globalOffset);

/// 判断是否接受数据的回调（不提供则默认接受所有数据）
typedef OnWillAccept<T> = bool Function(T? data);

/// 自定义外观 Builder，根据拖拽状态返回 Widget（例如拖拽进入时高亮边框）
typedef DropTargetBuilder = Widget Function(
  BuildContext context,
  bool isDraggingOver,
  Widget child,
);

/// 通用拖拽放置组件，支持任意类型 T
class GenericDropTarget<T extends Object> extends StatefulWidget {
  /// 展示区域，比如画布或列表等
  final Widget child;

  /// 拖拽释放时调用新版通用回调，传出数据及转换后的局部坐标
  final OnDrop<T>? onDrop;

  /// 旧版：接收拖拽数据并返回局部位置信息
  final OnAcceptWithPosition<T>? onAcceptWithPosition;

  /// 旧版：或者只接收拖拽数据
  final OnAccept<T>? onAccept;

  /// 可选：自定义全局到局部坐标转换逻辑（如需考虑缩放、偏移），默认为 RenderBox.globalToLocal
  final TransformOffset? transformOffset;

  /// 可选：判断是否接受拖拽数据的回调
  final OnWillAccept<T>? onWillAccept;

  /// 可选：自定义外观构建函数，可根据拖拽状态返回不同 Widget
  final DropTargetBuilder? builder;

  const GenericDropTarget({
    Key? key,
    required this.child,
    this.onDrop,
    this.onAcceptWithPosition,
    this.onAccept,
    this.transformOffset,
    this.onWillAccept,
    this.builder,
  }) : super(key: key);

  @override
  _GenericDropTargetState<T> createState() => _GenericDropTargetState<T>();
}

class _GenericDropTargetState<T extends Object>
    extends State<GenericDropTarget<T>> {
  bool _isDraggingOver = false;

  @override
  Widget build(BuildContext context) {
    // 使用 DragTarget<T> 处理拖拽事件
    Widget content = DragTarget<T>(
      onWillAccept: (data) {
        final accepted = widget.onWillAccept?.call(data) ?? true;
        setState(() {
          _isDraggingOver = accepted;
        });
        return accepted;
      },
      onAcceptWithDetails: (details) {
        final globalOffset = details.offset;
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox == null) {
          debugPrint('GenericDropTarget: RenderBox is null');
          return;
        }
        final localOffset = widget.transformOffset != null
            ? widget.transformOffset!(globalOffset)
            : renderBox.globalToLocal(globalOffset);
        // 优先调用新版回调
        if (widget.onDrop != null) {
          widget.onDrop!(details.data, localOffset);
        } else if (widget.onAcceptWithPosition != null) {
          widget.onAcceptWithPosition!(details.data, localOffset);
        } else if (widget.onAccept != null) {
          widget.onAccept!(details.data);
        }
        setState(() {
          _isDraggingOver = false;
        });
      },
      onLeave: (data) {
        setState(() {
          _isDraggingOver = false;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return widget.child;
      },
    );

    // 使用自定义 builder 包装内容；否则默认在拖拽进入状态添加边框高亮
    if (widget.builder != null) {
      return widget.builder!(context, _isDraggingOver, content);
    }
    return Container(
      decoration: _isDraggingOver
          ? BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 2.0))
          : null,
      child: content,
    );
  }
}
