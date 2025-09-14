import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor2.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/element_data.dart';
import 'package:class_namer/src/model/property_data.dart';
import 'package:class_namer/src/utils/ext/element/annotation_manager.dart';
import 'package:class_namer/src/utils/ext/string/element_data_handler.dart';
import 'package:class_namer/src/utils/ext/string/utility_name_validator.dart';
import 'package:class_namer_annotation/class_namer_annotation.dart';

/// An abstract class that defines the structure for visiting class elements
/// and extracting their data.
abstract class ClassNamerVisitor extends SimpleElementVisitor2<void> {
  /// The name of the class being visited.
  String get className;

  /// A map of constructor elements with their corresponding [ElementData].
  Map<String, ElementData> get constructors;

  /// A map of field elements with their corresponding [ElementData].
  Map<String, ElementData> get fields;

  /// A map of function elements with their corresponding [ElementData].
  Map<String, ElementData> get functions;

  /// A map of property elements with their corresponding [ElementData].
  Map<String, ElementData> get properties;

  /// Visits and processes mixins and super types of the given class element.
  ///
  /// The [element] parameter specifies the class element whose mixins and
  /// super types should be visited and processed.
  void visitMixinsAnsSuperTypes(ClassElement element);
}

class ImplClassNamerVisitor extends ClassNamerVisitor {
  final ClassNamerOptions _options;

  @override
  final String className;

  @override
  final constructors = <String, ElementData>{};
  @override
  final fields = <String, ElementData>{};
  @override
  final functions = <String, ElementData>{};
  @override
  final properties = <String, ElementData>{};

  ImplClassNamerVisitor(this._options, this.className);

  @override
  void visitMixinsAnsSuperTypes(ClassElement element) {
    _visitMixinsAndSupertypes(element);
  }

  void _visitMixinsAndSupertypes(InterfaceElement element) {
    if (_options.includeMixinsMembers) {
      _visitMixins(element);
    }

    if (_options.includeSuperMembers) {
      _visitSuperTypes(element);
    }
  }

  void _visitMixins(InterfaceElement element) {
    for (final mixin in element.mixins) {
      _visitClassElement(mixin.element);
    }
  }

  void _visitSuperTypes(InterfaceElement element) {
    final superClass = element.supertype?.element;
    if (superClass != null && superClass is ClassElement) {
      _visitMixinsAndSupertypes(superClass);
      _visitClassElement(superClass);
    }
  }

  @override
  void visitClassElement(ClassElement element) {
    _visitClassElement(element);
  }

  void _visitClassElement(InterfaceElement element) {
    for (final field in element.fields) {
      visitFieldElement(field);
    }

    for (final getter in element.getters) {
      visitGetterElement(getter);
    }

    for (final setter in element.setters) {
      visitSetterElement(setter);
    }

    for (final method in element.methods) {
      visitMethodElement(method);
    }
  }

  @override
  void visitGetterElement(GetterElement element) {
    if (element.isSynthetic) return;

    properties[element.displayName] = PropertyData.fromElementData(
      _getElementData(element, isIgnoreOption: _options.ignoreProperties),
      isSetter: false,
    );
  }

  @override
  void visitSetterElement(SetterElement element) {
    if (element.isSynthetic) return;

    properties[element.displayName] = PropertyData.fromElementData(
      _getElementData(element, isIgnoreOption: _options.ignoreProperties),
      isSetter: true,
    );
  }

  @override
  void visitConstructorElement(ConstructorElement element) {
    final name = element.name;

    if (name == null || name.isEmpty) {
      return;
    }

    if (element.isSynthetic ||
        element.name == null ||
        element.name!.isEmpty ||
        element.name == 'new') {
      return;
    }

    constructors[element.name!] = _getElementData(
      element,
      isIgnoreOption: _options.ignoreConstructors,
    );
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isSynthetic) {
      return;
    }

    fields[element.name!] = _getElementData(
      element,
      isIgnoreOption: _options.ignoreFields,
    );
  }

  @override
  void visitMethodElement(MethodElement element) {
    functions[element.name!] = _getElementData(
      element,
      isIgnoreOption: _options.ignoreMethods,
    );
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
