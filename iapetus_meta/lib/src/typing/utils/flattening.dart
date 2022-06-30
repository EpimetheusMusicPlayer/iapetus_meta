import 'package:iapetus_meta/src/typing/value_types/collection.dart';
import 'package:iapetus_meta/src/typing/value_types/value_type.dart';

extension ValueTypeFlattening on ValueType {
  Iterable<NestedObjectValueTypeEntry> flattenObjectTypes(String name) =>
      _flattenObjectTypes(name);

  Iterable<NestedObjectValueTypeEntry> _flattenObjectTypes(
    String name, {
    NestedObjectValueTypeParentCategory parentCategory =
        NestedObjectValueTypeParentCategory.root,
  }) sync* {
    final valueType = this;
    if (valueType is TypedJsonObjectValueType) {
      yield NestedObjectValueTypeEntry(
        name: name,
        parentCategory: parentCategory,
        valueType: valueType,
      );
      for (final entry in valueType.fieldValueTypes.entries) {
        yield* entry.value._flattenObjectTypes(
          entry.key,
          parentCategory: NestedObjectValueTypeParentCategory.object,
        );
      }
    } else if (valueType is TypedListValueType) {
      yield* valueType.elementValueType._flattenObjectTypes(
        name,
        parentCategory: NestedObjectValueTypeParentCategory.list,
      );
    } else if (valueType is TypedJsonMapValueType) {
      yield* valueType.keyValueType._flattenObjectTypes(
        name,
        parentCategory: NestedObjectValueTypeParentCategory.map,
      );
      yield* valueType.valueValueType._flattenObjectTypes(
        name,
        parentCategory: NestedObjectValueTypeParentCategory.map,
      );
    }
  }
}

enum NestedObjectValueTypeParentCategory {
  root(jsonValue: 'root'),
  object(jsonValue: 'object'),
  map(jsonValue: 'map'),
  list(jsonValue: 'list');

  final String jsonValue;

  const NestedObjectValueTypeParentCategory({required this.jsonValue});

  String toJson() => jsonValue;
}

class NestedObjectValueTypeEntry<J, D> {
  final String name;
  final NestedObjectValueTypeParentCategory parentCategory;
  final TypedJsonObjectValueType<J, D> valueType;

  const NestedObjectValueTypeEntry({
    required this.name,
    required this.parentCategory,
    required this.valueType,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'parentCategory': parentCategory.toJson(),
        'type': valueType,
      };
}
