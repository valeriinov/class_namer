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

  /// Collects and processes members from the given interface element.
  ///
  /// The [element] parameter specifies the interface element whose fields,
  /// getters, setters, methods, and constructors should be visited and
  /// collected into the corresponding maps.
  void collectFrom(InterfaceElement element);

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
  void collectFrom(InterfaceElement element) {
    _visitFields(element);
    _visitGetters(element);
    _visitSetters(element);
    _visitMethods(element);
    _visitConstructors(element);
  }

  @override
  void visitMixinsAnsSuperTypes(ClassElement element) {
    _visitMixinsAndSupertypes(element);
  }

  void _visitMixinsAndSupertypes(InterfaceElement element) {
    if (_options.includeMixinsMembers) {
      _visitMixins(element);
    }

    if (_options.includeSuperMembers) {
      _visitSupers(element);
    }
  }

  void _visitMixins(InterfaceElement element) {
    for (final mixinType in element.mixins) {
      final mixinElement = mixinType.element;

      collectFrom(mixinElement);
    }
  }

  void _visitSupers(InterfaceElement element) {
    final superElement = element.supertype?.element;

    if (superElement is ClassElement) {
      _visitMixinsAndSupertypes(superElement);
      collectFrom(superElement);
    }
  }

  void _visitFields(InterfaceElement element) {
    for (final field in element.fields) {
      visitFieldElement(field);
    }
  }

  void _visitGetters(InterfaceElement element) {
    for (final getter in element.getters) {
      visitGetterElement(getter);
    }
  }

  void _visitSetters(InterfaceElement element) {
    for (final setter in element.setters) {
      visitSetterElement(setter);
    }
  }

  void _visitMethods(InterfaceElement element) {
    for (final method in element.methods) {
      visitMethodElement(method);
    }
  }

  void _visitConstructors(InterfaceElement element) {
    for (final constructor in element.constructors) {
      if (_isUnnamedConstructor(element, constructor)) {
        continue;
      }

      visitConstructorElement(constructor);
    }
  }

  @override
  void visitConstructorElement(ConstructorElement element) {
    final data = _getData(element, _options.ignoreConstructors);

    constructors[_clean(_validateAndExtractName(element))] = data;
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isOriginGetterSetter) {
      return;
    }

    final data = _getData(element, _options.ignoreFields);

    fields[_clean(_validateAndExtractName(element))] = data;
  }

  @override
  void visitGetterElement(GetterElement element) {
    if (element.isOriginVariable) {
      return;
    }

    final data = _getData(element, _options.ignoreProperties);

    properties[_clean(_validateAndExtractName(element))] =
        PropertyData.fromElementData(data, isSetter: false);
  }

  @override
  void visitSetterElement(SetterElement element) {
    if (element.isOriginVariable) {
      return;
    }

    final data = _getData(element, _options.ignoreProperties);

    properties[_clean(_validateAndExtractName(element))] =
        PropertyData.fromElementData(data, isSetter: true);
  }

  @override
  void visitMethodElement(MethodElement element) {
    final data = _getData(element, _options.ignoreMethods);

    functions[_clean(_validateAndExtractName(element))] = data;
  }

  bool _isUnnamedConstructor(
    InterfaceElement owner,
    ConstructorElement constructor,
  ) {
    if (_isOwnerUnnamedConstructor(owner, constructor)) {
      return true;
    }

    return switch (constructor.name) {
      null => true,
      '' => true,
      'new' => true,
      _ => false,
    };
  }

  bool _isOwnerUnnamedConstructor(
    InterfaceElement owner,
    ConstructorElement constructor,
  ) {
    if (owner is! ClassElement) {
      return false;
    }

    return identical(owner.unnamedConstructor, constructor);
  }

  ElementData _getData(Element element, bool isIgnoreOption) {
    final name = _clean(_validateAndExtractName(element));
    final isPrivate = name.startsWith('_');
    final isIgnore = _shouldIgnore(element, name, isIgnoreOption);

    return ElementData(name: name, isPrivate: isPrivate, isIgnore: isIgnore);
  }

  String _validateAndExtractName(Element element) {
    final name = element.name;

    if (name == null || name.isEmpty) {
      throw UnsupportedError('Element does not have a name!');
    }

    return name;
  }

  String _clean(String raw) {
    return raw.cleanNameFromServiceSymbols();
  }

  bool _shouldIgnore(Element element, String name, bool isIgnoreOption) {
    return name.isEmpty ||
        element.hasAnnotation(ClassNamerIgnore) ||
        (_options.ignoreUtilities && name.isUtilityName) ||
        isIgnoreOption;
  }
}
