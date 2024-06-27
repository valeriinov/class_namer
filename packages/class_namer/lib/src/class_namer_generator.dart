import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_namer/src/utils/service_provider.dart';
import 'package:class_namer_annotation/class_namer_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// A generator that processes annotated elements with [ClassNamer] and generates
/// corresponding code based on the provided options.
class ClassNamerGenerator extends GeneratorForAnnotation<ClassNamer> {
  final ServiceProvider _serviceProvider;

  ClassNamerGenerator(this._serviceProvider);

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS && element.kind.name != 'MIXIN') {
      throw UnsupportedError("This is not a class (or mixin)!");
    }
    if (element.name == null) {
      throw UnsupportedError('Class or mixin element does not have a name!');
    }

    final optionsHandler = _serviceProvider.getOptionsHandler();

    final options = optionsHandler.getOptions(annotation);

    final visitor =
        _serviceProvider.createClassNamerVisitor(options, element.name!);

    element.visitChildren(visitor);

    final processor = _serviceProvider.createCodeProcessor(
        visitor: visitor, options: options);

    return processor.generateCode();
  }
}
