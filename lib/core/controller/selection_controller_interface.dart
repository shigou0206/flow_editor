/// 选区控制接口，提供节点和边的选中、清空操作
abstract class ISelectionController {
  /// 选中一组节点（会清除已有的节点选区）
  Future<void> selectNodes(Set<String> nodeIds);

  /// 选中一组边（会清除已有的边选区）
  Future<void> selectEdges(Set<String> edgeIds);

  /// 清空所有选区（节点和边）
  Future<void> clearSelection();
}
