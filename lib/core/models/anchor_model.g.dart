// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anchor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnchorModelImpl _$$AnchorModelImplFromJson(Map<String, dynamic> json) =>
    _$AnchorModelImpl(
      id: json['id'] as String,
      size: json['size'] == null
          ? const Size(24, 24)
          : const SizeConverter()
              .fromJson(json['size'] as Map<String, dynamic>),
      position: $enumDecodeNullable(_$PositionEnumMap, json['position']) ??
          Position.left,
      ratio: (json['ratio'] as num?)?.toDouble() ?? 0.5,
      direction:
          $enumDecodeNullable(_$AnchorDirectionEnumMap, json['direction']) ??
              AnchorDirection.inout,
      maxConnections: (json['maxConnections'] as num?)?.toInt(),
      acceptedEdgeTypes: (json['acceptedEdgeTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      shape: $enumDecodeNullable(_$AnchorShapeEnumMap, json['shape']) ??
          AnchorShape.circle,
      arrowDirection: $enumDecodeNullable(
              _$ArrowDirectionEnumMap, json['arrowDirection']) ??
          ArrowDirection.none,
      locked: json['locked'] as bool? ?? false,
      version: (json['version'] as num?)?.toInt() ?? 1,
      lockedByUser: json['lockedByUser'] as String?,
      plusButtonColorHex: json['plusButtonColorHex'] as String?,
      plusButtonSize: (json['plusButtonSize'] as num?)?.toDouble(),
      iconName: json['iconName'] as String?,
      data: json['data'] as Map<String, dynamic>? ?? const {},
      placement:
          $enumDecodeNullable(_$AnchorPlacementEnumMap, json['placement']) ??
              AnchorPlacement.border,
      offsetDistance: (json['offsetDistance'] as num?)?.toDouble() ?? 0.0,
      angle: (json['angle'] as num?)?.toDouble() ?? 0.0,
      nodeId: json['nodeId'] as String,
    );

Map<String, dynamic> _$$AnchorModelImplToJson(_$AnchorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'position': _$PositionEnumMap[instance.position]!,
      'ratio': instance.ratio,
      'direction': _$AnchorDirectionEnumMap[instance.direction]!,
      'maxConnections': instance.maxConnections,
      'acceptedEdgeTypes': instance.acceptedEdgeTypes,
      'shape': _$AnchorShapeEnumMap[instance.shape]!,
      'arrowDirection': _$ArrowDirectionEnumMap[instance.arrowDirection]!,
      'locked': instance.locked,
      'version': instance.version,
      'lockedByUser': instance.lockedByUser,
      'plusButtonColorHex': instance.plusButtonColorHex,
      'plusButtonSize': instance.plusButtonSize,
      'iconName': instance.iconName,
      'data': instance.data,
      'placement': _$AnchorPlacementEnumMap[instance.placement]!,
      'offsetDistance': instance.offsetDistance,
      'angle': instance.angle,
      'nodeId': instance.nodeId,
    };

const _$PositionEnumMap = {
  Position.left: 'left',
  Position.right: 'right',
  Position.top: 'top',
  Position.bottom: 'bottom',
};

const _$AnchorDirectionEnumMap = {
  AnchorDirection.inOnly: 'inOnly',
  AnchorDirection.outOnly: 'outOnly',
  AnchorDirection.inout: 'inout',
};

const _$AnchorShapeEnumMap = {
  AnchorShape.circle: 'circle',
  AnchorShape.diamond: 'diamond',
  AnchorShape.square: 'square',
  AnchorShape.custom: 'custom',
};

const _$ArrowDirectionEnumMap = {
  ArrowDirection.inward: 'inward',
  ArrowDirection.outward: 'outward',
  ArrowDirection.none: 'none',
};

const _$AnchorPlacementEnumMap = {
  AnchorPlacement.inside: 'inside',
  AnchorPlacement.border: 'border',
  AnchorPlacement.outside: 'outside',
};
