import 'package:json_annotation/json_annotation.dart';

enum MergeStrategy {
  @JsonValue('overwrite')
  overwrite,

  @JsonValue('ignore')
  ignore,

  @JsonValue('append')
  append,

  @JsonValue('merge')
  merge,
}
