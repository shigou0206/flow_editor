import 'package:freezed_annotation/freezed_annotation.dart';

part 'preserve_fields.freezed.dart';
part 'preserve_fields.g.dart';

@freezed
sealed class PreserveFields with _$PreserveFields {
  const factory PreserveFields.all() = AllPreserveFields;
  const factory PreserveFields.none() = NonePreserveFields;
  const factory PreserveFields.some(List<String> fields) = SomePreserveFields;

  factory PreserveFields.fromJson(Map<String, dynamic> json) =>
      _$PreserveFieldsFromJson(json);
}
