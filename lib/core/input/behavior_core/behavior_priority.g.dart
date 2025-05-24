// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'behavior_priority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BehaviorPriorityImpl _$$BehaviorPriorityImplFromJson(
        Map<String, dynamic> json) =>
    _$BehaviorPriorityImpl(
      anchorHover: (json['anchorHover'] as num?)?.toInt() ?? 5,
      nodeHover: (json['nodeHover'] as num?)?.toInt() ?? 6,
      edgeHover: (json['edgeHover'] as num?)?.toInt() ?? 7,
      nodeDrag: (json['nodeDrag'] as num?)?.toInt() ?? 10,
      edgeDraw: (json['edgeDraw'] as num?)?.toInt() ?? 20,
      marqueeSelect: (json['marqueeSelect'] as num?)?.toInt() ?? 30,
      resizeNode: (json['resizeNode'] as num?)?.toInt() ?? 40,
      canvasPan: (json['canvasPan'] as num?)?.toInt() ?? 50,
      canvasZoom: (json['canvasZoom'] as num?)?.toInt() ?? 60,
      deleteKey: (json['deleteKey'] as num?)?.toInt() ?? 100,
      copyPasteKey: (json['copyPasteKey'] as num?)?.toInt() ?? 110,
      undoRedoKey: (json['undoRedoKey'] as num?)?.toInt() ?? 120,
    );

Map<String, dynamic> _$$BehaviorPriorityImplToJson(
        _$BehaviorPriorityImpl instance) =>
    <String, dynamic>{
      'anchorHover': instance.anchorHover,
      'nodeHover': instance.nodeHover,
      'edgeHover': instance.edgeHover,
      'nodeDrag': instance.nodeDrag,
      'edgeDraw': instance.edgeDraw,
      'marqueeSelect': instance.marqueeSelect,
      'resizeNode': instance.resizeNode,
      'canvasPan': instance.canvasPan,
      'canvasZoom': instance.canvasZoom,
      'deleteKey': instance.deleteKey,
      'copyPasteKey': instance.copyPasteKey,
      'undoRedoKey': instance.undoRedoKey,
    };
