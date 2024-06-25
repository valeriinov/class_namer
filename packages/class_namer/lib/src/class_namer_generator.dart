import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_namer/src/class_namer_processor.dart';
import 'package:class_namer/src/class_namer_visitor.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer_annotation/class_namer_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ClassNamerGenerator extends GeneratorForAnnotation<ClassNamer> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS && element.kind.name != 'MIXIN') {
      throw UnsupportedError("This is not a class (or mixin)!");
    }

    final options = _getOptions(annotation);

    final visitor = ClassNamerVisitor(options);

    element.visitChildren(visitor);

    final code =
        ClassNamerProcessor(visitor: visitor, options: options).process();

    return code;
  }

  ClassNamerOptions _getOptions(ConstantReader annotation) {
    final ignoreClassName =
        _getOptionValue(annotation, 'ignoreClassName') ?? true;
    final ignoreConstructors =
        _getOptionValue(annotation, 'ignoreConstructors') ?? true;
    final ignoreMethods = _getOptionValue(annotation, 'ignoreMethods') ?? true;
    final ignoreFields = _getOptionValue(annotation, 'ignoreFields') ?? false;
    final ignoreProperties =
        _getOptionValue(annotation, 'ignoreProperties') ?? false;

    return ClassNamerOptions(
        ignoreClassName: ignoreClassName,
        ignoreConstructors: ignoreConstructors,
        ignoreMethods: ignoreMethods,
        ignoreFields: ignoreFields,
        ignoreProperties: ignoreProperties);
  }

  bool? _getOptionValue(ConstantReader annotation, String field) {
    return annotation.read(field).objectValue.toBoolValue();
  }
}
