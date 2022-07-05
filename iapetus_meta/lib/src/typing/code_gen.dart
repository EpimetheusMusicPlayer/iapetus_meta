import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:iapetus_meta/src/typing/utils/flattening.dart';
import 'package:iapetus_meta/src/typing/value_types/collection.dart';
import 'package:iapetus_meta/src/typing/value_types/value_type.dart';
import 'package:recase/recase.dart';

extension LibraryValueTypeCodeGen on Iterable<NestedObjectValueTypeEntry> {
  Library buildLibrary(String name) {
    final filename = name.snakeCase;
    return Library(
      (b) => b
        ..directives.add(Directive.part('$filename.freezed.dart'))
        ..directives.add(Directive.part('$filename.g.dart'))
        ..body.addAll(map((entry) => entry.valueType.buildClass(entry.name))),
    );
  }
}

extension ObjectValueTypeCodeGen on TypedJsonObjectValueType {
  Class buildClass(String name) {
    final className = name.pascalCase;
    return Class(
      (b) => b
        ..annotations.add(
          const Reference(
            'freezed',
            'package:freezed_annotation/freezed_annotation.dart',
          ),
        )
        ..name = className
        ..mixins.add(Reference('_\$$className'))
        ..constructors.add(
          Constructor(
            (b) => b
              ..constant = true
              ..factory = true
              ..redirect = Reference('_$className')
              ..optionalParameters.addAll(
                fieldValueTypes.entries
                    .map((entry) => entry.value.buildParameter(entry.key)),
              ),
          ),
        )
        ..constructors.add(
          Constructor(
            (b) => b
              ..factory = true
              ..name = 'fromJson'
              ..requiredParameters.add(
                Parameter(
                  (b) => b
                    ..name = 'json'
                    ..type = TypeReference(
                      (b) => b
                        ..symbol = 'Map'
                        ..url = 'dart:core'
                        ..types.add(const Reference('String', 'dart:core'))
                        ..types.add(const Reference('dynamic')),
                    ),
                ),
              )
              ..lambda = true
              ..body = InvokeExpression.newOf(
                Reference('_\$${className}FromJson'),
                [const Reference('json')],
              ).code,
          ),
        ),
    );
  }
}

extension FieldValueTypeCodeGen on ValueType {
  Parameter buildParameter(String name) {
    final parameterName = name.camelCase;
    return Parameter(
      (b) => b
        ..annotations.add(
          InvokeExpression.newOf(
            const Reference('JsonKey',
                'package:freezed_annotation/freezed_annotation.dart'),
            const [],
            ({
              'name': literalString(name),
              'fromJson': fromJsonFunctionReference?.expression,
              'toJson': toJsonFunctionReference?.expression,
            }..removeWhere((key, value) => value == null))
                .cast(),
          ),
        )
        ..named = true
        ..required = !optional
        ..name = parameterName
        ..type = this is TypedJsonObjectValueType
            ? TypeReference(
                (b) => b
                  ..isNullable = optional
                  ..symbol = name.pascalCase,
              )
            : dartTypeReference,
    );
  }
  // TODO: Add default value annotations
}

extension LibraryCodeRendering on Library {
  String render() => DartFormatter().format(
        accept(
          DartEmitter(
            allocator: IapetusCodeBuilderAllocator(),
            orderDirectives: true,
            writeTrailingNamedParameterCommas: true,
            useNullSafetySyntax: true,
          ),
        ).toString(),
      );
}

class IapetusCodeBuilderAllocator implements Allocator {
  static const _doNotPrefix = {'dart:core'};

  final _imports = <String>{};

  @override
  String allocate(Reference reference) {
    final url = reference.url;
    if (url != null && !_doNotPrefix.contains(url)) {
      _imports.add(url);
    }
    return reference.symbol!;
  }

  @override
  Iterable<Directive> get imports => _imports.map((u) => Directive.import(u));
}
