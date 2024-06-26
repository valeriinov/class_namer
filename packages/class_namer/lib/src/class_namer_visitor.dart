import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/element_data.dart';
import 'package:class_namer/src/model/property_data.dart';
import 'package:class_namer/src/utils/ext/element/annotation_manager.dart';
import 'package:class_namer/src/utils/ext/string/element_data_handler.dart';
import 'package:class_namer/src/utils/ext/string/utility_name_validator.dart';
import 'package:class_namer_annotation/class_namer_annotation.dart';

class ClassNamerVisitor extends SimpleElementVisitor<void> {
  final ClassNamerOptions _options;

  String _className = '';

  String get className => _className;

  final constructors = <String, ElementData>{};
  final fields = <String, ElementData>{};
  final functions = <String, ElementData>{};
  final properties = <String, ElementData>{};

  ClassNamerVisitor(this._options);

  @override
  void visitConstructorElement(ConstructorElement element) {
    final String returnType = element.returnType.toString();

    _className = returnType.cleanTypeFromServiceSymbols();

    constructors[element.name] =
        _getElementData(element, isIgnoreOption: _options.ignoreConstructors);
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isSynthetic) return;

    fields[element.name] =
        _getElementData(element, isIgnoreOption: _options.ignoreFields);
  }

  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {
    if (element.isSynthetic) return;

    properties[element.name] = PropertyData.fromElementData(
        _getElementData(element, isIgnoreOption: _options.ignoreProperties),
        isSetter: element.isSetter);
  }

  @override
  void visitMethodElement(MethodElement element) {
    functions[element.name] =
        _getElementData(element, isIgnoreOption: _options.ignoreMethods);
  }

  ElementData _getElementData(Element element, {required bool isIgnoreOption}) {
    if (element.name == null) {
      throw UnsupportedError('Element does not have a name!');
    }

    String? name = element.name!.cleanNameFromServiceSymbols();

    final isPrivate = element.name!.startsWith('_');
    final isIgnore = _isIgnore(element, name, isIgnoreOption);

    return ElementData(name: name, isPrivate: isPrivate, isIgnore: isIgnore);
  }

  bool _isIgnore(Element element, String name, bool isIgnoreOption) {
    return element.hasAnnotation(ClassNamerIgnore) ||
        name.isEmpty ||
        (_options.ignoreUtilities && name.isUtilityName) ||
        isIgnoreOption;
  }
}
