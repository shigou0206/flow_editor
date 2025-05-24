// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction_transient_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IdleImpl _$$IdleImplFromJson(Map<String, dynamic> json) => _$IdleImpl(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$IdleImplToJson(_$IdleImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$DragNodeImpl _$$DragNodeImplFromJson(Map<String, dynamic> json) =>
    _$DragNodeImpl(
      nodeId: json['nodeId'] as String,
      startCanvas: const OffsetConverter()
          .fromJson(json['startCanvas'] as Map<String, dynamic>),
      lastCanvas: const OffsetConverter()
          .fromJson(json['lastCanvas'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DragNodeImplToJson(_$DragNodeImpl instance) =>
    <String, dynamic>{
      'nodeId': instance.nodeId,
      'startCanvas': const OffsetConverter().toJson(instance.startCanvas),
      'lastCanvas': const OffsetConverter().toJson(instance.lastCanvas),
      'type': instance.$type,
    };

_$DragEdgeImpl _$$DragEdgeImplFromJson(Map<String, dynamic> json) =>
    _$DragEdgeImpl(
      edgeId: json['edgeId'] as String,
      sourceNodeId: json['sourceNodeId'] as String,
      sourceAnchorId: json['sourceAnchorId'] as String,
      startCanvas: const OffsetConverter()
          .fromJson(json['startCanvas'] as Map<String, dynamic>),
      lastCanvas: const OffsetConverter()
          .fromJson(json['lastCanvas'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DragEdgeImplToJson(_$DragEdgeImpl instance) =>
    <String, dynamic>{
      'edgeId': instance.edgeId,
      'sourceNodeId': instance.sourceNodeId,
      'sourceAnchorId': instance.sourceAnchorId,
      'startCanvas': const OffsetConverter().toJson(instance.startCanvas),
      'lastCanvas': const OffsetConverter().toJson(instance.lastCanvas),
      'type': instance.$type,
    };

_$DragWaypointImpl _$$DragWaypointImplFromJson(Map<String, dynamic> json) =>
    _$DragWaypointImpl(
      edgeId: json['edgeId'] as String,
      pointIndex: (json['pointIndex'] as num).toInt(),
      originalPoint: const OffsetConverter()
          .fromJson(json['originalPoint'] as Map<String, dynamic>),
      startCanvas: const OffsetConverter()
          .fromJson(json['startCanvas'] as Map<String, dynamic>),
      lastCanvas: const OffsetConverter()
          .fromJson(json['lastCanvas'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DragWaypointImplToJson(_$DragWaypointImpl instance) =>
    <String, dynamic>{
      'edgeId': instance.edgeId,
      'pointIndex': instance.pointIndex,
      'originalPoint': const OffsetConverter().toJson(instance.originalPoint),
      'startCanvas': const OffsetConverter().toJson(instance.startCanvas),
      'lastCanvas': const OffsetConverter().toJson(instance.lastCanvas),
      'type': instance.$type,
    };

_$PanCanvasImpl _$$PanCanvasImplFromJson(Map<String, dynamic> json) =>
    _$PanCanvasImpl(
      startGlobal: const OffsetConverter()
          .fromJson(json['startGlobal'] as Map<String, dynamic>),
      lastGlobal: const OffsetConverter()
          .fromJson(json['lastGlobal'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PanCanvasImplToJson(_$PanCanvasImpl instance) =>
    <String, dynamic>{
      'startGlobal': const OffsetConverter().toJson(instance.startGlobal),
      'lastGlobal': const OffsetConverter().toJson(instance.lastGlobal),
      'type': instance.$type,
    };

_$SelectingAreaImpl _$$SelectingAreaImplFromJson(Map<String, dynamic> json) =>
    _$SelectingAreaImpl(
      selectionBox: const RectConverter()
          .fromJson(json['selectionBox'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SelectingAreaImplToJson(_$SelectingAreaImpl instance) =>
    <String, dynamic>{
      'selectionBox': const RectConverter().toJson(instance.selectionBox),
      'type': instance.$type,
    };

_$InsertingNodeImpl _$$InsertingNodeImplFromJson(Map<String, dynamic> json) =>
    _$InsertingNodeImpl(
      nodeType: json['nodeType'] as String,
      startCanvas: const OffsetConverter()
          .fromJson(json['startCanvas'] as Map<String, dynamic>),
      lastCanvas: const OffsetConverter()
          .fromJson(json['lastCanvas'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$InsertingNodeImplToJson(_$InsertingNodeImpl instance) =>
    <String, dynamic>{
      'nodeType': instance.nodeType,
      'startCanvas': const OffsetConverter().toJson(instance.startCanvas),
      'lastCanvas': const OffsetConverter().toJson(instance.lastCanvas),
      'type': instance.$type,
    };

_$InsertNodeToEdgeImpl _$$InsertNodeToEdgeImplFromJson(
        Map<String, dynamic> json) =>
    _$InsertNodeToEdgeImpl(
      nodeType: json['nodeType'] as String,
      edgeId: json['edgeId'] as String,
      startCanvas: const OffsetConverter()
          .fromJson(json['startCanvas'] as Map<String, dynamic>),
      lastCanvas: const OffsetConverter()
          .fromJson(json['lastCanvas'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$InsertNodeToEdgeImplToJson(
        _$InsertNodeToEdgeImpl instance) =>
    <String, dynamic>{
      'nodeType': instance.nodeType,
      'edgeId': instance.edgeId,
      'startCanvas': const OffsetConverter().toJson(instance.startCanvas),
      'lastCanvas': const OffsetConverter().toJson(instance.lastCanvas),
      'type': instance.$type,
    };

_$ResizingNodeImpl _$$ResizingNodeImplFromJson(Map<String, dynamic> json) =>
    _$ResizingNodeImpl(
      nodeId: json['nodeId'] as String,
      handlePosition: const OffsetConverter()
          .fromJson(json['handlePosition'] as Map<String, dynamic>),
      startCanvas: const OffsetConverter()
          .fromJson(json['startCanvas'] as Map<String, dynamic>),
      lastCanvas: const OffsetConverter()
          .fromJson(json['lastCanvas'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ResizingNodeImplToJson(_$ResizingNodeImpl instance) =>
    <String, dynamic>{
      'nodeId': instance.nodeId,
      'handlePosition': const OffsetConverter().toJson(instance.handlePosition),
      'startCanvas': const OffsetConverter().toJson(instance.startCanvas),
      'lastCanvas': const OffsetConverter().toJson(instance.lastCanvas),
      'type': instance.$type,
    };

_$HoveringNodeImpl _$$HoveringNodeImplFromJson(Map<String, dynamic> json) =>
    _$HoveringNodeImpl(
      nodeId: json['nodeId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$HoveringNodeImplToJson(_$HoveringNodeImpl instance) =>
    <String, dynamic>{
      'nodeId': instance.nodeId,
      'type': instance.$type,
    };

_$HoveringAnchorImpl _$$HoveringAnchorImplFromJson(Map<String, dynamic> json) =>
    _$HoveringAnchorImpl(
      nodeId: json['nodeId'] as String,
      anchorId: json['anchorId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$HoveringAnchorImplToJson(
        _$HoveringAnchorImpl instance) =>
    <String, dynamic>{
      'nodeId': instance.nodeId,
      'anchorId': instance.anchorId,
      'type': instance.$type,
    };

_$HoveringEdgeImpl _$$HoveringEdgeImplFromJson(Map<String, dynamic> json) =>
    _$HoveringEdgeImpl(
      edgeId: json['edgeId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$HoveringEdgeImplToJson(_$HoveringEdgeImpl instance) =>
    <String, dynamic>{
      'edgeId': instance.edgeId,
      'type': instance.$type,
    };

_$ContextMenuOpenImpl _$$ContextMenuOpenImplFromJson(
        Map<String, dynamic> json) =>
    _$ContextMenuOpenImpl(
      globalPosition: const OffsetConverter()
          .fromJson(json['globalPosition'] as Map<String, dynamic>),
      targetId: json['targetId'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ContextMenuOpenImplToJson(
        _$ContextMenuOpenImpl instance) =>
    <String, dynamic>{
      'globalPosition': const OffsetConverter().toJson(instance.globalPosition),
      'targetId': instance.targetId,
      'type': instance.$type,
    };

_$InsertingNodePreviewImpl _$$InsertingNodePreviewImplFromJson(
        Map<String, dynamic> json) =>
    _$InsertingNodePreviewImpl(
      node: NodeModel.fromJson(json['node'] as Map<String, dynamic>),
      canvasPos: const OffsetConverter()
          .fromJson(json['canvasPos'] as Map<String, dynamic>),
      highlightedEdgeId: json['highlightedEdgeId'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$InsertingNodePreviewImplToJson(
        _$InsertingNodePreviewImpl instance) =>
    <String, dynamic>{
      'node': instance.node,
      'canvasPos': const OffsetConverter().toJson(instance.canvasPos),
      'highlightedEdgeId': instance.highlightedEdgeId,
      'type': instance.$type,
    };
