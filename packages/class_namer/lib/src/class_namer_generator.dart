import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_namer/src/class_namer_processor.dart';
import 'package:class_namer/src/class_namer_visitor.dart';
import 'package:class_namer/src/utils/ext/constant_reader/class_namer_options_mapper.dart';
import 'package:class_namer_annotation/class_namer_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ClassNamerGenerator extends GeneratorForAnnotation<ClassNamer> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS && element.kind.name != 'MIXIN') {
      throw UnsupportedError("This is not a class (or mixin)!");
    }

    final options = annotation.toClassNamerOptions();

    final visitor = ClassNamerVisitor(options);

    element.visitChildren(visitor);

    final code =
        ClassNamerProcessor(visitor: visitor, options: options).process();

    return code;
  }
}
