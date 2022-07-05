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
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'PandoraType'
    ..url = 'package:iapetus/src/common/entities/pandora_type.dart';

  @override
  Reference? get mandatoryFromJsonFunctionReference => null;

  @override
  Reference? get optionalFromJsonFunctionReference => null;

  @override
  Reference? get mandatoryToJsonFunctionReference => null;

  @override
  Reference? get optionalToJsonFunctionReference => null;
}
