import 'package:iapetus/iapetus.dart';
import 'package:iapetus_meta/src/typing/value_types/collection.dart';
import 'package:iapetus_meta/src/typing/value_types/iapetus/iapetus_value_type.dart';
import 'package:iapetus_meta/src/typing/value_types/pandora_entity.dart';

class AnnotationValueType extends IapetusEntityValueType<MediaAnnotation> {
  const AnnotationValueType({required super.optional, super.defaultValue})
      : super(MediaAnnotation.fromJson);

  @override
  String get name => 'Annotation';

  @override
  AnnotationValueType asOptional({bool optional = true}) =>
      AnnotationValueType(optional: optional, defaultValue: defaultValue);

  @override
  Map<String, dynamic> mandatoryToJson(MediaAnnotation value) => value.toJson();
}

class AnnotationMapValueType extends TypedJsonMapValueType<String,
    Map<String, Object?>, MediaAnnotation> {
  AnnotationMapValueType({required super.optional, super.defaultValue})
      : super(
          keyValueType: const PandoraIdValueType(optional: false),
          valueValueType: const AnnotationValueType(optional: false),
        );

  @override
  AnnotationMapValueType asOptional({bool optional = true}) =>
      AnnotationMapValueType(optional: optional, defaultValue: defaultValue);
}
