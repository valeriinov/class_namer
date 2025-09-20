import 'package:analyzer/dart/element/element2.dart';
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
  void collectFrom(InterfaceElement2 element);

  /// Visits and processes mixins and super types of the given class element.
  ///
  /// The [element] parameter specifies the class element whose mixins and
  /// super types should be visited and processed.
  void visitMixinsAnsSuperTypes(ClassElement2 element);
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
  void collectFrom(InterfaceElement2 element) {
    _visitFields(element);
    _visitGetters(element);
    _visitSetters(element);
    _visitMethods(element);
    _visitConstructors(element);
  }

  @override
  void visitMixinsAnsSuperTypes(ClassElement2 element) {
    _visitMixinsAndSupertypes(element);
  }

  void _visitMixinsAndSupertypes(InterfaceElement2 element) {
    if (_options.includeMixinsMembers) {
      _visitMixins(element);
    }

    if (_options.includeSuperMembers) {
      _visitSupers(element);
    }
  }

  void _visitMixins(InterfaceElement2 element) {
    for (final mixinType in element.mixins) {
      final mixinElement = mixinType.element3;

      collectFrom(mixinElement);
    }
  }

  void _visitSupers(InterfaceElement2 element) {
    final superElement = element.supertype?.element3;

    if (superElement is ClassElement2) {
      _visitMixinsAndSupertypes(superElement);
      collectFrom(superElement);
    }
  }

  void _visitFields(InterfaceElement2 element) {
    for (final field in element.fields2) {
      visitFieldElement(field);
    }
  }

  void _visitGetters(InterfaceElement2 element) {
    for (final getter in element.getters2) {
      visitGetterElement(getter);
    }
  }

  void _visitSetters(InterfaceElement2 element) {
    for (final setter in element.setters2) {
      visitSetterElement(setter);
    }
  }

  void _visitMethods(InterfaceElement2 element) {
    for (final method in element.methods2) {
      visitMethodElement(method);
    }
  }

  void _visitConstructors(InterfaceElement2 element) {
    for (final constructor in element.constructors2) {
      if (_isUnnamedConstructor(element, constructor)) {
        continue;
      }

      visitConstructorElement(constructor);
    }
  }

  @override
  void visitConstructorElement(ConstructorElement2 element) {
    final data = _getData(element, _options.ignoreConstructors);

    constructors[_clean(_validateAndExtractName(element))] = data;
  }

  @override
  void visitFieldElement(FieldElement2 element) {
    if (element.isSynthetic) {
      return;
    }

    final data = _getData(element, _options.ignoreFields);

    fields[_clean(_validateAndExtractName(element))] = data;
  }

  @override
  void visitGetterElement(GetterElement element) {
    if (element.isSynthetic) {
      return;
    }

    final data = _getData(element, _options.ignoreProperties);

    properties[_clean(_validateAndExtractName(element))] =
        PropertyData.fromElementData(data, isSetter: false);
  }

  @override
  void visitSetterElement(SetterElement element) {
    if (element.isSynthetic) {
      return;
    }

    final data = _getData(element, _options.ignoreProperties);

    properties[_clean(_validateAndExtractName(element))] =
        PropertyData.fromElementData(data, isSetter: true);
  }

  @override
  void visitMethodElement(MethodElement2 element) {
    final data = _getData(element, _options.ignoreMethods);

    functions[_clean(_validateAndExtractName(element))] = data;
  }

  bool _isUnnamedConstructor(
    InterfaceElement2 owner,
    ConstructorElement2 constructor,
  ) {
    if (_isOwnerUnnamedConstructor(owner, constructor)) {
      return true;
    }

    return switch (constructor.name3) {
      null => true,
      '' => true,
      'new' => true,
      _ => false,
    };
  }

  bool _isOwnerUnnamedConstructor(
    InterfaceElement2 owner,
    ConstructorElement2 constructor,
  ) {
    if (owner is! ClassElement2) {
      return false;
    }

    return identical(owner.unnamedConstructor2, constructor);
  }

  ElementData _getData(Element2 element, bool isIgnoreOption) {
    final name = _clean(_validateAndExtractName(element));
    final isPrivate = name.startsWith('_');
    final isIgnore = _shouldIgnore(element, name, isIgnoreOption);

    return ElementData(name: name, isPrivate: isPrivate, isIgnore: isIgnore);
  }

  String _validateAndExtractName(Element2 element) {
    final name = element.name3;

    if (name == null || name.isEmpty) {
      throw UnsupportedError('Element does not have a name!');
    }

    return name;
  }

  String _clean(String raw) {
    return raw.cleanNameFromServiceSymbols();
  }

  bool _shouldIgnore(Element2 element, String name, bool isIgnoreOption) {
    return name.isEmpty ||
        element.hasAnnotation(ClassNamerIgnore) ||
        (_options.ignoreUtilities && name.isUtilityName) ||
        isIgnoreOption;
  }
}
