import 'package:code_builder/code_builder.dart';
import 'package:iapetus/iapetus_data.dart';
import 'package:iapetus_meta/src/typing/value_types/value_type.dart';

class CanBeEmptyStringValueType extends ComplexValueType<String, String?> {
  const CanBeEmptyStringValueType({
    required super.optional,
    super.defaultValue,
  });

  @override
  String get name => 'String';

  @override
  CanBeEmptyStringValueType asOptional({bool optional = true}) =>
      CanBeEmptyStringValueType(optional: optional, defaultValue: defaultValue);

  @override
  String? mandatoryFromJson(String value) => readOptionallyEmptyString(value);

  @override
  String? optionalFromJson(String? value) =>
      readOptionalOptionallyEmptyString(value);

  @override
  String mandatoryToJson(String? value) => writeOptionallyEmptyString(value);

  @override
  String? optionalToJson(String? value) => value;

  @override
  Reference get dartTypeReference => buildDartTypeReference(
        (b) => b
          ..symbol = 'String'
          ..url = 'dart:core',
      );
}
