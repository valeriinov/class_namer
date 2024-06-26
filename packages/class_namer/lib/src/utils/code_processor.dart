import 'package:class_namer/src/class_namer_visitor.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/element_data.dart';
import 'package:class_namer/src/model/property_data.dart';
import 'package:class_namer/src/utils/ext/string/element_data_handler.dart';

abstract interface class CodeProcessor {
  String generateCode();
}

class ImplCodeProcessor implements CodeProcessor {
  final ClassNamerOptions _options;
  final ClassNamerVisitor _visitor;
  StringBuffer _buffer = StringBuffer();

  ImplCodeProcessor(
      {required ClassNamerVisitor visitor, required ClassNamerOptions options})
      : _options = options,
        _visitor = visitor;

  @override
  String generateCode() {
    _buffer = StringBuffer();

    return _generateCode();
  }

  String _generateCode() {
    final classContainerName = '${_visitor.className}Names';

    _buffer.writeln(
        '/// Container for names of elements belonging to the [${_visitor.className}] class');
    _buffer.writeln('class $classContainerName {');

    _writeConstructor(classContainerName);

    _writeNames();

    _buffer.writeln('}');

    return _buffer.toString();
  }

  void _writeConstructor(String classContainerName) {
    _buffer.writeln('$classContainerName._();');
    _buffer.writeln();
  }

  void _writeNames() {
    _writeClassName();

    final namesList = _generateNames();

    for (final codeLines in namesList) {
      _writeCodeLines(codeLines);
    }
  }

  void _writeClassName() {
    final className = 'final String className = \'${_visitor.className}\';';

    if (!_options.ignoreClassName) _buffer.writeln(className);
  }

  List<Iterable<String>> _generateNames() {
    final constructorNames =
        _getCodeParts('constructor', _visitor.constructors.values);

    final fieldNames = _getCodeParts('field', _visitor.fields.values);

    final propertyNames = _getCodeParts('property', _visitor.properties.values);

    final functionNames = _getCodeParts('function', _visitor.functions.values);

    return [constructorNames, fieldNames, propertyNames, functionNames];
  }

  Iterable<String> _getCodeParts(
      String elementType, Iterable<ElementData> elements) {
    final filteredNames = _getFilteredNames(elements);

    return filteredNames.map((elData) {
      final propPrefix = elData is PropertyData ? elData.propertyPrefix : '';

      return 'final String $elementType$propPrefix'
          '${elData.name.capitalize().privatize()} = \'${elData.name}\';';
    });
  }

  Iterable<ElementData> _getFilteredNames(Iterable<ElementData> dataList) {
    return dataList.where((data) => !data.isPrivate && !data.isIgnore);
  }

  void _writeCodeLines(Iterable<String> codeLines) {
    if (codeLines.isNotEmpty) {
      _buffer.writeln();
      _buffer.writeln(join(codeLines));
    }
  }
}
