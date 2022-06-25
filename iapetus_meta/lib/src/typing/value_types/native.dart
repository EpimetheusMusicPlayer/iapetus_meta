import 'package:iapetus_meta/src/typing/value_types/collection.dart';
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
}

class StringValueType extends NativeValueType<String> {
  const StringValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'String';

  @override
  StringValueType asOptional({bool optional = true}) =>
      StringValueType(optional: optional, defaultValue: defaultValue);
}

class NumberValueType<T extends num> extends NativeValueType<T> {
  const NumberValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Number';

  @override
  NumberValueType<T> asOptional({bool optional = true}) =>
      NumberValueType<T>(optional: optional, defaultValue: defaultValue);
}

class IntegerValueType extends NumberValueType<int> {
  const IntegerValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Integer';

  @override
  IntegerValueType asOptional({bool optional = true}) =>
      IntegerValueType(optional: optional, defaultValue: defaultValue);
}

class DoubleValueType extends NumberValueType<double> {
  const DoubleValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Double';

  @override
  DoubleValueType asOptional({bool optional = true}) =>
      DoubleValueType(optional: optional, defaultValue: defaultValue);
}

class BooleanValueType extends NativeValueType<bool> {
  const BooleanValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Boolean';

  @override
  BooleanValueType asOptional({bool optional = true}) =>
      BooleanValueType(optional: optional, defaultValue: defaultValue);
}

// class GenericListValueType extends NativeValueType<List<dynamic>>
//     implements ListValueType<List<dynamic>> {
//   const GenericListValueType({required super.optional, super.defaultValue});
//
//   @override
//   String get name => 'List';
//
//   @override
//   GenericListValueType asOptional({bool optional = true}) =>
//       GenericListValueType(optional: optional, defaultValue: defaultValue);
// }
//
// class GenericJsonObjectValueType extends NativeValueType<Map<String, dynamic>>
//     implements JsonObjectValueType<Map<String, dynamic>> {
//   const GenericJsonObjectValueType({
//     required super.optional,
//     super.defaultValue,
//   });
//
//   @override
//   String get name => 'JSON object';
//
//   @override
//   GenericJsonObjectValueType asOptional({bool optional = true}) =>
//       GenericJsonObjectValueType(
//         optional: optional,
//         defaultValue: defaultValue,
//       );
// }
