import 'package:code_builder/code_builder.dart';
import 'package:iapetus/iapetus.dart';
import 'package:iapetus/iapetus_data.dart';
import 'package:iapetus_meta/src/typing/value_types/native.dart';
import 'package:iapetus_meta/src/typing/value_types/value_type.dart';
import 'package:json_annotation/json_annotation.dart';

class PandoraIdValueType extends StringValueType {
  const PandoraIdValueType({required super.optional, super.defaultValue});

  @override
  String get name => '${super.name}<Pandora ID>';

  @override
  PandoraIdValueType asOptional({bool optional = true}) =>
      PandoraIdValueType(optional: optional, defaultValue: defaultValue);

  @override
  Reference get dartTypeReference => buildDartTypeReference(
        (b) => b
          ..symbol = 'String'
          ..url = 'dart:core',
      );
}

class PandoraTypeValueType extends ComplexValueType<String, PandoraType> {
  const PandoraTypeValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Pandora type';

  @override
  PandoraTypeValueType asOptional({bool optional = true}) =>
      PandoraTypeValueType(optional: optional, defaultValue: defaultValue);

  @override
  PandoraType mandatoryFromJson(String value) =>
      $enumDecode(pandoraTypeEnumMap, value);

  @override
  String mandatoryToJson(PandoraType value) => pandoraTypeEnumMap[value]!;

  @override
  Reference get dartTypeReference => buildDartTypeReference(
        (b) => b
          ..symbol = 'PandoraType'
          ..url = 'package:iapetus/src/common/entities/pandora_type.dart',
      );
}
