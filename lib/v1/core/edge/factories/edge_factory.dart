// file: edge_factory.dart
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';
import 'package:flow_editor/v1/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/v1/core/edge/models/edge_animation_config.dart';

/// 用于存放默认配置或特殊逻辑
class EdgeTypeConfig {
  /// 默认样式
  final EdgeLineStyle? defaultLineStyle;

  /// 默认动画
  final EdgeAnimationConfig? defaultAnimConfig;

  /// 是否默认锁定
  final bool lockedByDefault;

  const EdgeTypeConfig({
    this.defaultLineStyle,
    this.defaultAnimConfig,
    this.lockedByDefault = false,
  });
}

/// EdgeFactory: 按类型（edgeType） 创建新的 EdgeModel，
/// 并可在同一处集中管理各类连线的默认属性(颜色、箭头、动画、是否锁定等)。
class EdgeFactory {
  // 存放各个 edgeType -> EdgeTypeConfig
  final Map<String, EdgeTypeConfig> _typeConfigs = {};

  /// 为某个 edgeType 注册一套默认配置
  void registerEdgeType(String edgeType, EdgeTypeConfig config) {
    _typeConfigs[edgeType] = config;
  }

  /// 依据 edgeType 创建一条新的 EdgeModel，
  /// 并可使用所注册的默认 lineStyle / animConfig / locked 等。
  EdgeModel createEdge({
    required String edgeType,
    required String sourceNodeId,
    required String sourceAnchorId,
    String? targetNodeId,
    String? targetAnchorId,
    bool? isConnected,
    // 其它字段(waypoints, label...) 若你想在此初始化可加
  }) {
    final config = _typeConfigs[edgeType];

    // 若没有注册, 用默认
    final lineStyle = config?.defaultLineStyle ?? const EdgeLineStyle();
    final animConfig = config?.defaultAnimConfig ?? const EdgeAnimationConfig();
    final locked = config?.lockedByDefault ?? false;

    return EdgeModel(
      id: _generateEdgeId(), // 你可使用 uuid 或自定义
      sourceNodeId: sourceNodeId,
      sourceAnchorId: sourceAnchorId,
      targetNodeId: targetNodeId,
      targetAnchorId: targetAnchorId,
      isConnected: isConnected ?? (targetNodeId != null),
      edgeType: edgeType,
      locked: locked,
      lineStyle: lineStyle,
      animConfig: animConfig,
      // version, zIndex, label, labelStyle, data... 可在此赋默认值
    );
  }

  /// 如果你想自动生成 edgeId
  String _generateEdgeId() {
    // 你可以用包: uuid: ^3.0.6
    // return const Uuid().v4();
    // 暂时使用当前毫秒为后缀
    return 'edge_${DateTime.now().millisecondsSinceEpoch}';
  }
}
