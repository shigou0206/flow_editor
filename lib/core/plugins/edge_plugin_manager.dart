import 'package:flow_editor/core/plugins/edge_plugin.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// Edge插件管理器
class EdgePluginManager {
  /// 注册的插件列表
  final Set<EdgePlugin> _plugins = {};

  /// 注册插件
  void registerPlugin(EdgePlugin plugin) {
    _plugins.add(plugin);
  }

  /// 注销插件
  void unregisterPlugin(EdgePlugin plugin) {
    _plugins.remove(plugin);
  }

  /// 通知插件Edge创建事件
  void notifyEdgeCreated(EdgeModel edge) {
    for (final plugin in _plugins) {
      plugin.onEdgeCreated(edge);
    }
  }

  /// 通知插件Edge删除事件
  void notifyEdgeDeleted(EdgeModel edge) {
    for (final plugin in _plugins) {
      plugin.onEdgeDeleted(edge);
    }
  }

  /// 通知插件Edge更新事件
  void notifyEdgeUpdated(EdgeModel oldEdge, EdgeModel newEdge) {
    for (final plugin in _plugins) {
      plugin.onEdgeUpdated(oldEdge, newEdge);
    }
  }

  /// 通知插件Edge被选中事件
  void notifyEdgeSelected(EdgeModel edge) {
    for (final plugin in _plugins) {
      plugin.onEdgeSelected(edge);
    }
  }

  /// 通知插件Edge取消选中事件
  void notifyEdgeDeselected(EdgeModel edge) {
    for (final plugin in _plugins) {
      plugin.onEdgeDeselected(edge);
    }
  }

  /// 清空所有已注册插件
  void clearPlugins() {
    _plugins.clear();
  }

  /// 获取已注册插件数量
  int get pluginCount => _plugins.length;
}
