import 'package:flow_editor/core/edge/models/edge_model.dart';

/// Edge插件抽象类，定义Edge生命周期事件
abstract class EdgePlugin {
  /// 当Edge被创建时调用
  void onEdgeCreated(EdgeModel edge) {}

  /// 当Edge被删除时调用
  void onEdgeDeleted(EdgeModel edge) {}

  /// 当Edge更新时调用
  void onEdgeUpdated(EdgeModel oldEdge, EdgeModel newEdge) {}

  /// 当Edge被选中时调用
  void onEdgeSelected(EdgeModel edge) {}

  /// 当Edge取消选中时调用
  void onEdgeDeselected(EdgeModel edge) {}
}
