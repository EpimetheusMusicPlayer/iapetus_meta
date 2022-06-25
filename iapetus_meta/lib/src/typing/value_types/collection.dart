import 'package:iapetus_meta/src/typing/value_types/native.dart';
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
}

class TypedJsonMapValueType<J, D>
    extends ComplexJsonObjectValueType<Map<String, D>> {
  final ValueType<String, String> keyValueType;
  final ValueType<J, D> valueValueType;

  const TypedJsonMapValueType({
    this.keyValueType = const StringValueType(optional: false),
    required this.valueValueType,
    required super.optional,
    super.defaultValue,
  });

  @override
  String get name => 'Map<${keyValueType.name}, ${valueValueType.name}>';

  @override
  TypedJsonMapValueType<J, D> asOptional({bool optional = true}) =>
      TypedJsonMapValueType(
        keyValueType: keyValueType,
        valueValueType: valueValueType,
        optional: optional,
        defaultValue: defaultValue,
      );

  @override
  Map<String, D> mandatoryFromJson(Map<String, dynamic> json) => json.map(
        (key, value) =>
            MapEntry(key, valueValueType.convertFromJson(value as J) as D),
      );

  @override
  Map<String, J> mandatoryToJson(Map<String, D> map) => map.map(
        (key, value) => MapEntry(key, valueValueType.convertToJson(value) as J),
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'keyType': keyValueType.toJson(),
        'valueType': valueValueType.toJson(),
      };
}

abstract class ListValueType<D>
    implements CollectionValueType<List<dynamic>, D> {}

abstract class ComplexListValueType<D>
    extends ComplexValueType<List<dynamic>, D> implements ListValueType<D> {
  const ComplexListValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'List';
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
}
