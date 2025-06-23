// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canvas_insert_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CanvasInsertElement _$CanvasInsertElementFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'node':
      return NodeInsertElement.fromJson(json);
    case 'group':
      return GroupInsertElement.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'CanvasInsertElement',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$CanvasInsertElement {
  @OffsetConverter()
  Offset get position => throw _privateConstructorUsedError;
  @SizeConverter()
  Size get size => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)
        node,
    required TResult Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)
        group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)?
        node,
    TResult? Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)?
        group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)?
        node,
    TResult Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)?
        group,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NodeInsertElement value) node,
    required TResult Function(GroupInsertElement value) group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NodeInsertElement value)? node,
    TResult? Function(GroupInsertElement value)? group,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NodeInsertElement value)? node,
    TResult Function(GroupInsertElement value)? group,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CanvasInsertElementCopyWith<CanvasInsertElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasInsertElementCopyWith<$Res> {
  factory $CanvasInsertElementCopyWith(
          CanvasInsertElement value, $Res Function(CanvasInsertElement) then) =
      _$CanvasInsertElementCopyWithImpl<$Res, CanvasInsertElement>;
  @useResult
  $Res call({@OffsetConverter() Offset position, @SizeConverter() Size size});
}

/// @nodoc
class _$CanvasInsertElementCopyWithImpl<$Res, $Val extends CanvasInsertElement>
    implements $CanvasInsertElementCopyWith<$Res> {
  _$CanvasInsertElementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? size = null,
  }) {
    return _then(_value.copyWith(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NodeInsertElementImplCopyWith<$Res>
    implements $CanvasInsertElementCopyWith<$Res> {
  factory _$$NodeInsertElementImplCopyWith(_$NodeInsertElementImpl value,
          $Res Function(_$NodeInsertElementImpl) then) =
      __$$NodeInsertElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@OffsetConverter() Offset position,
      @SizeConverter() Size size,
      NodeModel node});

  $NodeModelCopyWith<$Res> get node;
}

/// @nodoc
class __$$NodeInsertElementImplCopyWithImpl<$Res>
    extends _$CanvasInsertElementCopyWithImpl<$Res, _$NodeInsertElementImpl>
    implements _$$NodeInsertElementImplCopyWith<$Res> {
  __$$NodeInsertElementImplCopyWithImpl(_$NodeInsertElementImpl _value,
      $Res Function(_$NodeInsertElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? size = null,
    Object? node = null,
  }) {
    return _then(_$NodeInsertElementImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      node: null == node
          ? _value.node
          : node // ignore: cast_nullable_to_non_nullable
              as NodeModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeModelCopyWith<$Res> get node {
    return $NodeModelCopyWith<$Res>(_value.node, (value) {
      return _then(_value.copyWith(node: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$NodeInsertElementImpl implements NodeInsertElement {
  const _$NodeInsertElementImpl(
      {@OffsetConverter() this.position = Offset.zero,
      @SizeConverter() this.size = const Size(200, 40),
      required this.node,
      final String? $type})
      : $type = $type ?? 'node';

  factory _$NodeInsertElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$NodeInsertElementImplFromJson(json);

  @override
  @JsonKey()
  @OffsetConverter()
  final Offset position;
  @override
  @JsonKey()
  @SizeConverter()
  final Size size;
  @override
  final NodeModel node;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'CanvasInsertElement.node(position: $position, size: $size, node: $node)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NodeInsertElementImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.node, node) || other.node == node));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, position, size, node);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NodeInsertElementImplCopyWith<_$NodeInsertElementImpl> get copyWith =>
      __$$NodeInsertElementImplCopyWithImpl<_$NodeInsertElementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)
        node,
    required TResult Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)
        group,
  }) {
    return node(position, size, this.node);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)?
        node,
    TResult? Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)?
        group,
  }) {
    return node?.call(position, size, this.node);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)?
        node,
    TResult Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)?
        group,
    required TResult orElse(),
  }) {
    if (node != null) {
      return node(position, size, this.node);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NodeInsertElement value) node,
    required TResult Function(GroupInsertElement value) group,
  }) {
    return node(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NodeInsertElement value)? node,
    TResult? Function(GroupInsertElement value)? group,
  }) {
    return node?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NodeInsertElement value)? node,
    TResult Function(GroupInsertElement value)? group,
    required TResult orElse(),
  }) {
    if (node != null) {
      return node(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NodeInsertElementImplToJson(
      this,
    );
  }
}

abstract class NodeInsertElement implements CanvasInsertElement {
  const factory NodeInsertElement(
      {@OffsetConverter() final Offset position,
      @SizeConverter() final Size size,
      required final NodeModel node}) = _$NodeInsertElementImpl;

  factory NodeInsertElement.fromJson(Map<String, dynamic> json) =
      _$NodeInsertElementImpl.fromJson;

  @override
  @OffsetConverter()
  Offset get position;
  @override
  @SizeConverter()
  Size get size;
  NodeModel get node;
  @override
  @JsonKey(ignore: true)
  _$$NodeInsertElementImplCopyWith<_$NodeInsertElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupInsertElementImplCopyWith<$Res>
    implements $CanvasInsertElementCopyWith<$Res> {
  factory _$$GroupInsertElementImplCopyWith(_$GroupInsertElementImpl value,
          $Res Function(_$GroupInsertElementImpl) then) =
      __$$GroupInsertElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@OffsetConverter() Offset position,
      @SizeConverter() Size size,
      NodeModel groupNode,
      List<NodeModel> children,
      List<EdgeModel> edges});

  $NodeModelCopyWith<$Res> get groupNode;
}

/// @nodoc
class __$$GroupInsertElementImplCopyWithImpl<$Res>
    extends _$CanvasInsertElementCopyWithImpl<$Res, _$GroupInsertElementImpl>
    implements _$$GroupInsertElementImplCopyWith<$Res> {
  __$$GroupInsertElementImplCopyWithImpl(_$GroupInsertElementImpl _value,
      $Res Function(_$GroupInsertElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
    Object? size = null,
    Object? groupNode = null,
    Object? children = null,
    Object? edges = null,
  }) {
    return _then(_$GroupInsertElementImpl(
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      groupNode: null == groupNode
          ? _value.groupNode
          : groupNode // ignore: cast_nullable_to_non_nullable
              as NodeModel,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      edges: null == edges
          ? _value._edges
          : edges // ignore: cast_nullable_to_non_nullable
              as List<EdgeModel>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeModelCopyWith<$Res> get groupNode {
    return $NodeModelCopyWith<$Res>(_value.groupNode, (value) {
      return _then(_value.copyWith(groupNode: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupInsertElementImpl implements GroupInsertElement {
  const _$GroupInsertElementImpl(
      {@OffsetConverter() this.position = Offset.zero,
      @SizeConverter() this.size = const Size(200, 40),
      required this.groupNode,
      required final List<NodeModel> children,
      required final List<EdgeModel> edges,
      final String? $type})
      : _children = children,
        _edges = edges,
        $type = $type ?? 'group';

  factory _$GroupInsertElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupInsertElementImplFromJson(json);

  @override
  @JsonKey()
  @OffsetConverter()
  final Offset position;
  @override
  @JsonKey()
  @SizeConverter()
  final Size size;
  @override
  final NodeModel groupNode;
  final List<NodeModel> _children;
  @override
  List<NodeModel> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final List<EdgeModel> _edges;
  @override
  List<EdgeModel> get edges {
    if (_edges is EqualUnmodifiableListView) return _edges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edges);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'CanvasInsertElement.group(position: $position, size: $size, groupNode: $groupNode, children: $children, edges: $edges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupInsertElementImpl &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.groupNode, groupNode) ||
                other.groupNode == groupNode) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            const DeepCollectionEquality().equals(other._edges, _edges));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      position,
      size,
      groupNode,
      const DeepCollectionEquality().hash(_children),
      const DeepCollectionEquality().hash(_edges));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupInsertElementImplCopyWith<_$GroupInsertElementImpl> get copyWith =>
      __$$GroupInsertElementImplCopyWithImpl<_$GroupInsertElementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)
        node,
    required TResult Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)
        group,
  }) {
    return group(position, size, groupNode, children, edges);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)?
        node,
    TResult? Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)?
        group,
  }) {
    return group?.call(position, size, groupNode, children, edges);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@OffsetConverter() Offset position,
            @SizeConverter() Size size, NodeModel node)?
        node,
    TResult Function(
            @OffsetConverter() Offset position,
            @SizeConverter() Size size,
            NodeModel groupNode,
            List<NodeModel> children,
            List<EdgeModel> edges)?
        group,
    required TResult orElse(),
  }) {
    if (group != null) {
      return group(position, size, groupNode, children, edges);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NodeInsertElement value) node,
    required TResult Function(GroupInsertElement value) group,
  }) {
    return group(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NodeInsertElement value)? node,
    TResult? Function(GroupInsertElement value)? group,
  }) {
    return group?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NodeInsertElement value)? node,
    TResult Function(GroupInsertElement value)? group,
    required TResult orElse(),
  }) {
    if (group != null) {
      return group(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupInsertElementImplToJson(
      this,
    );
  }
}

abstract class GroupInsertElement implements CanvasInsertElement {
  const factory GroupInsertElement(
      {@OffsetConverter() final Offset position,
      @SizeConverter() final Size size,
      required final NodeModel groupNode,
      required final List<NodeModel> children,
      required final List<EdgeModel> edges}) = _$GroupInsertElementImpl;

  factory GroupInsertElement.fromJson(Map<String, dynamic> json) =
      _$GroupInsertElementImpl.fromJson;

  @override
  @OffsetConverter()
  Offset get position;
  @override
  @SizeConverter()
  Size get size;
  NodeModel get groupNode;
  List<NodeModel> get children;
  List<EdgeModel> get edges;
  @override
  @JsonKey(ignore: true)
  _$$GroupInsertElementImplCopyWith<_$GroupInsertElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
