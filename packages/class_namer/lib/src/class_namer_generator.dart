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
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    _validateElement(element);

    final name = _validateAndExtractName(element);
    final options = _serviceProvider.getOptionsHandler().getOptions(annotation);
    final visitor = _serviceProvider.createClassNamerVisitor(options, name);

    if (element is InterfaceElement) {
      visitor.collectFrom(element);

      if (element is ClassElement) {
        visitor.visitMixinsAnsSuperTypes(element);
      }
    }

    final processor = _serviceProvider.createCodeProcessor(
      visitor: visitor,
      options: options,
    );
    return processor.generateCode();
  }

  void _validateElement(Element element) {
    if (element is ClassElement || element is MixinElement) {
      return;
    }

    throw UnsupportedError("This is not a class (or mixin)!");
  }

  String _validateAndExtractName(Element element) {
    final name = element.name;

    if (name == null || name.isEmpty) {
      throw UnsupportedError('Class/mixin has no name!');
    }

    return name;
  }
}
