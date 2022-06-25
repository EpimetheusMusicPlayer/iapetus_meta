import 'package:iapetus_meta/src/typing/value_types/collection.dart';

abstract class IapetusEntityValueType<T> extends ComplexJsonObjectValueType<T> {
  final T Function(Map<String, dynamic> json) fromJsonFactory;

  const IapetusEntityValueType(
    this.fromJsonFactory, {
    required super.optional,
    super.defaultValue,
  });

  @override
  T mandatoryFromJson(Map<String, dynamic> json) => fromJsonFactory(json);
}
