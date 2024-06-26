import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_namer/src/utils/service_provider.dart';
import 'package:class_namer_annotation/class_namer_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ClassNamerGenerator extends GeneratorForAnnotation<ClassNamer> {
  final ServiceProvider _serviceProvider;

  ClassNamerGenerator(this._serviceProvider);

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS && element.kind.name != 'MIXIN') {
      throw UnsupportedError("This is not a class (or mixin)!");
    }

    final optionsHandler = _serviceProvider.getOptionsHandler();

    final options = optionsHandler.getOptions(annotation);

    final visitor = _serviceProvider.createClassNamerVisitor(options);

    element.visitChildren(visitor);

    final processor = _serviceProvider.createCodeProcessor(
        visitor: visitor, options: options);

    return processor.generateCode();
  }
}
