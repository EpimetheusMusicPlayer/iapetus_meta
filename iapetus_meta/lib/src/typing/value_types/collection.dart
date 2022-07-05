import 'package:code_builder/code_builder.dart';
import 'package:iapetus_meta/src/typing/value_types/value_type.dart';

abstract class CollectionValueType<T, D> implements ValueType<T, D> {}

abstract class JsonObjectValueType<D>
    implements CollectionValueType<Map<String, dynamic>, D> {}

abstract class ComplexJsonObjectValueType<D>
    extends ComplexValueType<Map<String, dynamic>, D>
    implements JsonObjectValueType<D> {
  const ComplexJsonObjectValueType({
    required super.optional,
    super.defaultValue,
  });

  @override
  String get name => 'JSON object';

  @override
  Reference? get mandatoryFromJsonFunctionReference => null;

  @override
  Reference? get optionalFromJsonFunctionReference => null;

  @override
  Reference? get mandatoryToJsonFunctionReference => null;

  @override
  Reference? get optionalToJsonFunctionReference => null;
}

class TypedJsonObjectValueType<J, D>
    extends ComplexJsonObjectValueType<Map<String, D>> {
  final Map<String, ValueType<J, D>> fieldValueTypes;

  const TypedJsonObjectValueType({
    required this.fieldValueTypes,
    required super.optional,
    super.defaultValue,
  });

  @override
  TypedJsonObjectValueType<J, D> asOptional({bool optional = true}) =>
      TypedJsonObjectValueType(
        fieldValueTypes: fieldValueTypes,
        optional: optional,
        defaultValue: defaultValue,
      );

  @override
  Map<String, D> mandatoryFromJson(Map<String, dynamic> json) => json.map(
        (key, value) => MapEntry(
          key,
          fieldValueTypes[key]!.convertFromJson(value as J) as D,
        ),
      );

  @override
  Map<String, J> mandatoryToJson(Map<String, D> map) => map.map(
        (key, value) =>
            MapEntry(key, fieldValueTypes[key]!.convertToJson(value) as J),
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'fields':
            fieldValueTypes.map((key, value) => MapEntry(key, value.toJson())),
      };

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'Map'
    ..url = 'dart:core'
    ..types.add(const Reference('String', 'dart:core'))
    ..types.add(const Reference('dynamic'));
}

class TypedJsonMapValueType<K, J, D>
    extends ComplexJsonObjectValueType<Map<K, D>> {
  final ValueType<String, K> keyValueType;
  final ValueType<J, D> valueValueType;

  const TypedJsonMapValueType({
    required this.keyValueType,
    required this.valueValueType,
    required super.optional,
    super.defaultValue,
  });

  @override
  String get name => 'Map<${keyValueType.name}, ${valueValueType.name}>';

  @override
  TypedJsonMapValueType<K, J, D> asOptional({bool optional = true}) =>
      TypedJsonMapValueType(
        keyValueType: keyValueType,
        valueValueType: valueValueType,
        optional: optional,
        defaultValue: defaultValue,
      );

  @override
  Map<K, D> mandatoryFromJson(Map<String, dynamic> json) => json.map(
        (key, value) => MapEntry(
          keyValueType.convertFromJson(key) as K,
          valueValueType.convertFromJson(value as J) as D,
        ),
      );

  @override
  Map<String, J> mandatoryToJson(Map<K, D> map) => map.map(
        (key, value) => MapEntry(
          keyValueType.convertToJson(key)!,
          valueValueType.convertToJson(value) as J,
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'keyType': keyValueType.toJson(),
        'valueType': valueValueType.toJson(),
      };

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'Map'
    ..url = 'dart:core'
    ..types.add(keyValueType.dartTypeReference)
    ..types.add(valueValueType.dartTypeReference);
}

abstract class ListValueType<D>
    implements CollectionValueType<List<dynamic>, D> {}

abstract class ComplexListValueType<D>
    extends ComplexValueType<List<dynamic>, D> implements ListValueType<D> {
  const ComplexListValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'List';

  @override
  Reference? get mandatoryFromJsonFunctionReference => null;

  @override
  Reference? get optionalFromJsonFunctionReference => null;

  @override
  Reference? get mandatoryToJsonFunctionReference => null;

  @override
  Reference? get optionalToJsonFunctionReference => null;
}

class TypedListValueType<J, D> extends ComplexListValueType<List<D>> {
  final ValueType elementValueType;

  const TypedListValueType(
    this.elementValueType, {
    required super.optional,
    super.defaultValue,
  });

  @override
  String get name => '${super.name}<${elementValueType.name}>';

  @override
  TypedListValueType<J, D> asOptional({bool optional = true}) =>
      TypedListValueType(
        elementValueType,
        optional: optional,
        defaultValue: defaultValue,
      );

  @override
  List<D> mandatoryFromJson(List<dynamic> json) => json
      .map((element) => elementValueType.convertFromJson(element) as D)
      .toList(growable: false);

  @override
  List<J> mandatoryToJson(List<D> list) => list
      .map((element) => elementValueType.convertToJson(element) as J)
      .toList(growable: false);

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'elementType': elementValueType.toJson(),
      };

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'List'
    ..url = 'dart:core'
    ..types.add(elementValueType.dartTypeReference);
}
