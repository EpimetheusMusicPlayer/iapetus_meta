import 'package:code_builder/code_builder.dart';
import 'package:iapetus/iapetus_data.dart';
import 'package:iapetus_meta/src/typing/value_types/value_type.dart';

abstract class TimestampValueType<J> extends ComplexValueType<J, DateTime> {
  const TimestampValueType({required super.optional, super.defaultValue});

  @override
  String get name => 'Timestamp';

  @override
  void updateDartTypeReference(TypeReferenceBuilder b) => b
    ..symbol = 'DateTime'
    ..url = 'dart:core';
}

class DateValueType extends TimestampValueType<String> {
  const DateValueType({required super.optional, super.defaultValue});

  @override
  String get name => '${super.name}<Date>';

  @override
  DateValueType asOptional({bool optional = true}) =>
      DateValueType(optional: optional, defaultValue: defaultValue);

  @override
  DateTime mandatoryFromJson(String dateString) =>
      readDateTimeDateString(dateString);

  @override
  DateTime? optionalFromJson(String? dateString) =>
      readOptionalDateTimeDateString(dateString);

  @override
  String mandatoryToJson(DateTime dateTime) =>
      writeDateTimeDateString(dateTime);

  @override
  String? optionalToJson(DateTime? dateTime) =>
      writeOptionalDateTimeDateString(dateTime);

  @override
  Reference get mandatoryFromJsonFunctionReference => const Reference(
        'readDateTimeDateString',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get optionalFromJsonFunctionReference => const Reference(
        'readOptionalDateTimeDateString',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get mandatoryToJsonFunctionReference => const Reference(
        'writeDateTimeDateString',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get optionalToJsonFunctionReference => const Reference(
        'writeOptionalDateTimeDateString',
        'package:iapetus/src/common/data/json_utils.dart',
      );
}

abstract class EpochTimestampValueType extends TimestampValueType<int> {
  const EpochTimestampValueType({required super.optional, super.defaultValue});

  @override
  String get name => '${super.name}<Epoch';
}

class MicrosecondTimestampValueType extends EpochTimestampValueType {
  const MicrosecondTimestampValueType({
    required super.optional,
    super.defaultValue,
  });

  @override
  String get name => '${super.name}<Microseconds>>';

  @override
  MicrosecondTimestampValueType asOptional({bool optional = true}) =>
      MicrosecondTimestampValueType(
        optional: optional,
        defaultValue: defaultValue,
      );

  @override
  DateTime mandatoryFromJson(int microseconds) =>
      readDateTimeMicroseconds(microseconds);

  @override
  DateTime? optionalFromJson(int? microseconds) =>
      readOptionalDateTimeMicroseconds(microseconds);

  @override
  int mandatoryToJson(DateTime dateTime) => writeDateTimeMicroseconds(dateTime);

  @override
  int? optionalToJson(DateTime? dateTime) =>
      writeOptionalDateTimeMicroseconds(dateTime);

  @override
  Reference get mandatoryFromJsonFunctionReference => const Reference(
        'readDateTimeMicroseconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get optionalFromJsonFunctionReference => const Reference(
        'readOptionalDateTimeMicroseconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get mandatoryToJsonFunctionReference => const Reference(
        'writeDateTimeMicroseconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get optionalToJsonFunctionReference => const Reference(
        'writeOptionalDateTimeMicroseconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );
}

class MillisecondTimestampValueType extends EpochTimestampValueType {
  const MillisecondTimestampValueType({
    required super.optional,
    super.defaultValue,
  });

  @override
  String get name => '${super.name}<Milliseconds>>';

  @override
  MillisecondTimestampValueType asOptional({bool optional = true}) =>
      MillisecondTimestampValueType(
        optional: optional,
        defaultValue: defaultValue,
      );

  @override
  DateTime mandatoryFromJson(int milliseconds) =>
      readDateTimeMilliseconds(milliseconds);

  @override
  DateTime? optionalFromJson(int? milliseconds) =>
      readOptionalDateTimeMilliseconds(milliseconds);

  @override
  int mandatoryToJson(DateTime dateTime) => writeDateTimeMilliseconds(dateTime);

  @override
  int? optionalToJson(DateTime? dateTime) =>
      writeOptionalDateTimeMilliseconds(dateTime);

  @override
  Reference get mandatoryFromJsonFunctionReference => const Reference(
        'readDateTimeMilliseconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get optionalFromJsonFunctionReference => const Reference(
        'readOptionalDateTimeMilliseconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get mandatoryToJsonFunctionReference => const Reference(
        'writeDateTimeMilliseconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get optionalToJsonFunctionReference => const Reference(
        'writeOptionalDateTimeMilliseconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );
}

class SecondTimestampValueType extends EpochTimestampValueType {
  const SecondTimestampValueType({required super.optional, super.defaultValue});

  @override
  String get name => '${super.name}<Seconds>>';

  @override
  SecondTimestampValueType asOptional({bool optional = true}) =>
      SecondTimestampValueType(optional: optional, defaultValue: defaultValue);

  @override
  DateTime mandatoryFromJson(int seconds) => readDateTimeSeconds(seconds);

  @override
  DateTime? optionalFromJson(int? seconds) =>
      readOptionalDateTimeSeconds(seconds);

  @override
  int mandatoryToJson(DateTime dateTime) => writeDateTimeSeconds(dateTime);

  @override
  int? optionalToJson(DateTime? dateTime) =>
      writeOptionalDateTimeSeconds(dateTime);

  @override
  Reference get mandatoryFromJsonFunctionReference => const Reference(
        'readDateTimeSeconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get optionalFromJsonFunctionReference => const Reference(
        'readOptionalDateTimeSeconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get mandatoryToJsonFunctionReference => const Reference(
        'writeDateTimeSeconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );

  @override
  Reference get optionalToJsonFunctionReference => const Reference(
        'writeOptionalDateTimeSeconds',
        'package:iapetus/src/common/data/json_utils.dart',
      );
}
