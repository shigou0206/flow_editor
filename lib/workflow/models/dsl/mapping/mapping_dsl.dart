import 'package:freezed_annotation/freezed_annotation.dart';
import 'mapping_rule.dart';
import 'preserve_fields.dart';

part 'mapping_dsl.freezed.dart';
part 'mapping_dsl.g.dart';

@freezed
class MappingDSL with _$MappingDSL {
  const factory MappingDSL({
    String? namespace,
    String? version,
    String? description,
    @Default(PreserveFields.none()) PreserveFields preserve,
    @Default(false) bool debug,
    required List<MappingRule> mappings,
  }) = _MappingDSL;

  factory MappingDSL.fromJson(Map<String, dynamic> json) =>
      _$MappingDSLFromJson(json);
}
