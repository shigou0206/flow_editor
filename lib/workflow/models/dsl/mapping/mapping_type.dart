import 'package:json_annotation/json_annotation.dart';

enum MappingType {
  @JsonValue('Constant')
  constant,

  @JsonValue('JsonPath')
  jsonPath,

  @JsonValue('Expr')
  expr,

  @JsonValue('Template')
  template,

  @JsonValue('SubMapping')
  subMapping,
}
