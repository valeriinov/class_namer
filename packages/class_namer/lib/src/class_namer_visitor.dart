import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/element_data.dart';
import 'package:class_namer/src/model/property_data.dart';
import 'package:class_namer/src/utils/ext/string/element_data_handler.dart';

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
        _getElementData(element, isIgnore: _options.ignoreConstructors);
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isSynthetic) return;

    fields[element.name] =
        _getElementData(element, isIgnore: _options.ignoreFields);
  }

  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {
    if (element.isSynthetic) return;

    properties[element.name] = PropertyData.fromElementData(
        _getElementData(element, isIgnore: _options.ignoreProperties),
        isSetter: element.isSetter);
  }

  @override
  void visitMethodElement(MethodElement element) {
    functions[element.name] =
        _getElementData(element, isIgnore: _options.ignoreMethods);
  }

  ElementData _getElementData(Element element, {bool isIgnore = false}) {
    if (element.name == null) {
      throw UnsupportedError('Element does not have a name!');
    }

    final isPrivate = element.name!.startsWith('_');

    String? name = element.name!.cleanNameFromServiceSymbols();

    return ElementData(name: name, isPrivate: isPrivate, isIgnore: isIgnore);
  }
}
