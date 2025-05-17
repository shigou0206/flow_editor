import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/style/edge_line_style.dart';
import 'package:flow_editor/v2/core/models/style/edge_animation_config.dart';
import 'package:flow_editor/v2/core/utils/edge_utils.dart';
import 'package:flow_editor/v2/core/models/edge_attachment_model.dart';

/// 坐标空间：
/// * world     – 画布绝对坐标
/// * workflow  – 工作流根局部坐标，parentId = workflowId
/// * group     – 任意分组/子图局部坐标，parentId = groupNodeId
enum CoordSpace { world, workflow, group }

/// 通用 Edge 模型：
/// * `start / end` 必填，始终保存 **当前 coordSpace 下的坐标**
/// * 若填写 source/targetNodeId，则表示工作流连线；否则就是自由几何线
class EdgeModel {
  // ======= 基本几何 =======
  final String id;
  final Offset? start;
  final Offset? end;

  final List<EdgeAttachmentModel> attachments;

  // 坐标空间 & 归属父级
  final CoordSpace coordSpace;
  final String? parentId; // 当 coordSpace != world 时必填

  // ===== 绑定节点（可选） =====
  final String? sourceNodeId;
  final String? sourceAnchorId;
  final String? targetNodeId;
  final String? targetAnchorId;
  final bool isConnected;

  // ===== 样式 / 路径 =====
  final bool isDirected;
  final List<Offset>? waypoints; // 同样处于 coordSpace
  final EdgeLineStyle lineStyle;
  final EdgeAnimationConfig animConfig;

  // ===== 业务字段 =====
  final String edgeType;
  final String? status;
  final int zIndex;
  final bool locked;
  final String? lockedByUser;
  final int version;

  // ===== 标签 / 扩展 =====
  final String? label;
  final Map<String, dynamic>? labelStyle;
  final Map<String, dynamic> data;

  // ------------ ctor ------------
  EdgeModel({
    // geometry
    this.start,
    this.end,
    this.attachments = const [],
    // space
    this.coordSpace = CoordSpace.world,
    this.parentId,

    // node bind (optional)
    this.sourceNodeId,
    this.sourceAnchorId,
    this.targetNodeId,
    this.targetAnchorId,
    this.isConnected = false,

    // style
    this.isDirected = true,
    this.waypoints,
    this.lineStyle = const EdgeLineStyle(),
    this.animConfig = const EdgeAnimationConfig(),

    // business
    this.edgeType = 'default',
    this.status,
    this.zIndex = 0,
    this.locked = false,
    this.lockedByUser,
    this.version = 1,

    // label / extra
    this.label,
    this.labelStyle,
    this.data = const {},

    // id override
    String? id,
  }) : id = id ??
            _genId(
              sourceNodeId,
              targetNodeId,
              sourceAnchorId,
              targetAnchorId,
              label,
              isDirected,
            );

  static String _genId(
    String? sid,
    String? tid,
    String? sa,
    String? ta,
    String? label,
    bool isDirected,
  ) {
    if (sid != null && tid != null) {
      return EdgeIdFactory.generateEdgeId(
        sid,
        tid,
        sa,
        ta,
        label,
        isDirected: isDirected,
      );
    }
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  // ------------ copyWith ------------
  EdgeModel copyWith({
    Offset? start,
    Offset? end,
    List<EdgeAttachmentModel>? attachments,
    CoordSpace? coordSpace,
    String? parentId,
    String? sourceNodeId,
    String? sourceAnchorId,
    String? targetNodeId,
    String? targetAnchorId,
    bool? isConnected,
    bool? isDirected,
    List<Offset>? waypoints,
    EdgeLineStyle? lineStyle,
    EdgeAnimationConfig? animConfig,
    String? edgeType,
    String? status,
    int? zIndex,
    bool? locked,
    String? lockedByUser,
    int? version,
    String? label,
    Map<String, dynamic>? labelStyle,
    Map<String, dynamic>? data,
  }) {
    return EdgeModel(
      id: id,
      start: start ?? this.start,
      end: end ?? this.end,
      attachments: attachments ?? this.attachments,
      coordSpace: coordSpace ?? this.coordSpace,
      parentId: parentId ?? this.parentId,
      sourceNodeId: sourceNodeId ?? this.sourceNodeId,
      sourceAnchorId: sourceAnchorId ?? this.sourceAnchorId,
      targetNodeId: targetNodeId ?? this.targetNodeId,
      targetAnchorId: targetAnchorId ?? this.targetAnchorId,
      isConnected: isConnected ?? this.isConnected,
      isDirected: isDirected ?? this.isDirected,
      waypoints: waypoints ?? this.waypoints,
      lineStyle: lineStyle ?? this.lineStyle,
      animConfig: animConfig ?? this.animConfig,
      edgeType: edgeType ?? this.edgeType,
      status: status ?? this.status,
      zIndex: zIndex ?? this.zIndex,
      locked: locked ?? this.locked,
      lockedByUser: lockedByUser ?? this.lockedByUser,
      version: version ?? this.version,
      label: label ?? this.label,
      labelStyle: labelStyle ?? this.labelStyle,
      data: data ?? this.data,
    );
  }

  // ------------ JSON ------------
  Map<String, dynamic> toJson() => {
        'id': id,
        'start': [start?.dx, start?.dy],
        'end': [end?.dx, end?.dy],
        'attachments': attachments.map((a) => a.toJson()).toList(),
        'coordSpace': coordSpace.name,
        'parentId': parentId,
        'sourceNodeId': sourceNodeId,
        'sourceAnchorId': sourceAnchorId,
        'targetNodeId': targetNodeId,
        'targetAnchorId': targetAnchorId,
        'isConnected': isConnected,
        'isDirected': isDirected,
        'waypoints': waypoints?.map((o) => [o.dx, o.dy]).toList(),
        'lineStyle': lineStyle.toJson(),
        'animConfig': animConfig.toJson(),
        'edgeType': edgeType,
        'status': status,
        'zIndex': zIndex,
        'locked': locked,
        'lockedByUser': lockedByUser,
        'version': version,
        'label': label,
        'labelStyle': labelStyle,
        'data': data,
      };

  factory EdgeModel.fromJson(Map<String, dynamic> j) => EdgeModel(
        id: j['id'] as String?,
        start: _off(j['start']),
        end: _off(j['end']),
        attachments: (j['attachments'] as List?)
                ?.map((a) => EdgeAttachmentModel.fromJson(a))
                .toList() ??
            [],
        coordSpace: CoordSpace.values.firstWhere(
          (e) => e.name == (j['coordSpace'] ?? 'world'),
          orElse: () => CoordSpace.world,
        ),
        parentId: j['parentId'] as String?,
        sourceNodeId: j['sourceNodeId'] as String?,
        sourceAnchorId: j['sourceAnchorId'] as String?,
        targetNodeId: j['targetNodeId'] as String?,
        targetAnchorId: j['targetAnchorId'] as String?,
        isConnected: j['isConnected'] as bool? ?? false,
        isDirected: j['isDirected'] as bool? ?? true,
        waypoints: (j['waypoints'] as List?)?.map(_off).toList(),
        lineStyle: j['lineStyle'] is Map<String, dynamic>
            ? EdgeLineStyle.fromJson(j['lineStyle'])
            : const EdgeLineStyle(),
        animConfig: j['animConfig'] is Map<String, dynamic>
            ? EdgeAnimationConfig.fromJson(j['animConfig'])
            : const EdgeAnimationConfig(),
        edgeType: j['edgeType'] as String? ?? 'default',
        status: j['status'] as String?,
        zIndex: (j['zIndex'] as num?)?.toInt() ?? 0,
        locked: j['locked'] as bool? ?? false,
        lockedByUser: j['lockedByUser'] as String?,
        version: (j['version'] as num?)?.toInt() ?? 1,
        label: j['label'] as String?,
        labelStyle: j['labelStyle'] as Map<String, dynamic>?,
        data: j['data'] as Map<String, dynamic>? ?? {},
      );

  static Offset _off(dynamic v) =>
      Offset((v[0] as num).toDouble(), (v[1] as num).toDouble());
}
