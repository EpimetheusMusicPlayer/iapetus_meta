import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

abstract class ValueType<J, D> {
  const ValueType();

  String get name;

  bool get optional;

  D? get defaultValue;

  ValueType<J, D> asOptional({bool optional = true});

  D? convertFromJson(J? value);

  J? convertToJson(D? value);

  Reference get dartTypeReference;

  Reference? get fromJsonFunctionReference;

  Reference? get toJsonFunctionReference;

  Map<String, dynamic> toJson() => {
        'type': name,
        'optional': optional,
        if (optional) 'defaultValue': convertToJson(defaultValue),
      };
}

abstract class ComplexValueType<J, D> extends ValueType<J, D> {
  @override
  final bool optional;

  @override
  final D? defaultValue;

  const ComplexValueType({required this.optional, this.defaultValue});

  D mandatoryFromJson(J value);

  D? optionalFromJson(J? value) =>
      value == null ? null : mandatoryFromJson(value);

  J mandatoryToJson(D value);

  J? optionalToJson(D? value) => value == null ? null : mandatoryToJson(value);

  @override
  D? convertFromJson(J? value) => optional
      ? optionalFromJson(value) ?? defaultValue
      : mandatoryFromJson(value as J);

  @override
  J? convertToJson(D? value) =>
      optional ? optionalToJson(value) : mandatoryToJson(value as D);

  @protected
  void updateDartTypeReference(TypeReferenceBuilder b);

  Reference? get mandatoryFromJsonFunctionReference;

  Reference? get optionalFromJsonFunctionReference;

  Reference? get mandatoryToJsonFunctionReference;

  Reference? get optionalToJsonFunctionReference;

  @override
  Reference? get fromJsonFunctionReference => optional
      ? optionalFromJsonFunctionReference
      : mandatoryFromJsonFunctionReference;

  @override
  Reference? get toJsonFunctionReference => optional
      ? optionalToJsonFunctionReference
      : mandatoryToJsonFunctionReference;

  @override
  Reference get dartTypeReference => TypeReference(
        (b) => b
          ..isNullable = optional
          ..update(updateDartTypeReference),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplexValueType &&
          runtimeType == other.runtimeType &&
          optional == other.optional &&
          defaultValue == other.defaultValue;

  @override
  int get hashCode => Object.hash(defaultValue, optional);
}
