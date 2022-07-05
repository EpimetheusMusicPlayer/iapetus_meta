import 'package:code_builder/code_builder.dart';
import 'package:iapetus_meta/src/typing/value_types/value_type.dart';

class NativeValueType<T> extends ComplexValueType<T, T> {
  const NativeValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Value';

  @override
  NativeValueType<T> asOptional({bool optional = true}) =>
      NativeValueType(optional: optional, defaultValue: defaultValue);

  @override
  T mandatoryFromJson(T value) => value;

  @override
  T mandatoryToJson(T value) => value;

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'Object'
    ..url = 'dart:core';

  @override
  Reference? get mandatoryFromJsonFunctionReference => null;

  @override
  Reference? get optionalFromJsonFunctionReference => null;

  @override
  Reference? get mandatoryToJsonFunctionReference => null;

  @override
  Reference? get optionalToJsonFunctionReference => null;
}

/// A [ValueType] representing an unknown value.
///
/// This should be used in cases where a `null` value is encountered, and the
/// type of the value cannot be determined without more sample data.
class UnknownValueType extends NativeValueType<dynamic> {
  const UnknownValueType({required super.optional, super.defaultValue})
      : assert(
          optional,
          'It makes no sense to have a non-optional unknown value type!',
        );

  @override
  String get name => 'Unknown';

  @override
  UnknownValueType asOptional({bool optional = true}) =>
      UnknownValueType(optional: optional, defaultValue: defaultValue);

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b..symbol = 'dynamic';
}

class StringValueType extends NativeValueType<String> {
  const StringValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'String';

  @override
  StringValueType asOptional({bool optional = true}) =>
      StringValueType(optional: optional, defaultValue: defaultValue);

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'String'
    ..url = 'dart:core';
}

class NumberValueType<T extends num> extends NativeValueType<T> {
  const NumberValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Number';

  @override
  NumberValueType<T> asOptional({bool optional = true}) =>
      NumberValueType<T>(optional: optional, defaultValue: defaultValue);

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'num'
    ..url = 'dart:core';
}

class IntegerValueType extends NumberValueType<int> {
  const IntegerValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Integer';

  @override
  IntegerValueType asOptional({bool optional = true}) =>
      IntegerValueType(optional: optional, defaultValue: defaultValue);

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'int'
    ..url = 'dart:core';
}

class DoubleValueType extends NumberValueType<double> {
  const DoubleValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Double';

  @override
  DoubleValueType asOptional({bool optional = true}) =>
      DoubleValueType(optional: optional, defaultValue: defaultValue);

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'double'
    ..url = 'dart:core';
}

class BooleanValueType extends NativeValueType<bool> {
  const BooleanValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Boolean';

  @override
  BooleanValueType asOptional({bool optional = true}) =>
      BooleanValueType(optional: optional, defaultValue: defaultValue);

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'bool'
    ..url = 'dart:core';
}
