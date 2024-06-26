import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_namer/src/class_namer_processor.dart';
import 'package:class_namer/src/class_namer_visitor.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/class_namer_options_dto.dart';
import 'package:class_namer/src/utils/ext/constant_reader/class_namer_options_mapper.dart';
import 'package:class_namer/src/utils/ext/options_mapper.dart';
import 'package:class_namer_annotation/class_namer_annotation.dart';
import 'package:source_gen/source_gen.dart';

class ClassNamerGenerator extends GeneratorForAnnotation<ClassNamer> {
  final ClassNamerOptionsDto _initOptionsDto;

  ClassNamerGenerator(this._initOptionsDto);

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
    final annotationOptionsDto = annotation.toClassNamerOptionsDto();

    final optionsDto = _initOptionsDto.copyWithOptionsDto(annotationOptionsDto);

    return optionsDto.toClassNamerOptions();
  }
}
