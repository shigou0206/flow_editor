import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 边相关的操作接口
abstract class IEdgeController {
  /// 新增一条边
  Future<void> addEdge(EdgeModel edge);

  /// 删除指定 ID 的边
  Future<void> deleteEdge(String edgeId);

  /// 移动边的端点，从 [from] 到 [to]
  Future<void> moveEdge(String edgeId, Offset from, Offset to);

  /// 更新边属性：接收一个“旧边 -> 新边”的更新函数
  Future<void> updateEdgeProperty(
    String edgeId,
    EdgeModel Function(EdgeModel) updateFn,
  );
}
