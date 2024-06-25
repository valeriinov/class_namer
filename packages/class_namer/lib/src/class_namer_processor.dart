import 'package:class_namer/src/class_namer_visitor.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/element_data.dart';
import 'package:class_namer/src/model/property_data.dart';
import 'package:class_namer/src/utils/ext/string/element_data_handler.dart';

class ClassNamerProcessor {
  final ClassNamerOptions _options;
  final ClassNamerVisitor _visitor;

  ClassNamerProcessor(
      {required ClassNamerVisitor visitor, required ClassNamerOptions options})
      : _options = options,
        _visitor = visitor;

  String process() {
    return _generateNames();
  }

  String _generateNames() {
    StringBuffer buffer = StringBuffer();

    final classContainerName = '${_visitor.className}Names';

    buffer.writeln(
        '/// Container for names of elements belonging to the [${_visitor.className}] class');
    buffer.writeln('class $classContainerName {');

    buffer.writeln('$classContainerName._();');
    buffer.writeln();

    final className = 'final String className = \'${_visitor.className}\';';

    final constructorNames =
        _getCodeParts('constructor', _visitor.constructors.values);

    final fieldNames = _getCodeParts('field', _visitor.fields.values);

    final functionNames = _getCodeParts('function', _visitor.functions.values);

    final propertyNames = _getFilteredNames(_visitor.properties.values).map(
        (prop) =>
            'final String property${(prop as PropertyData).propertyPrefix}${prop.name.capitalize().privatize()} = \'${prop.name}\';');

    void writeCode(Iterable<String> codeLines) {
      if (codeLines.isNotEmpty) {
        buffer.writeln();
        buffer.writeln(join(codeLines));
      }
    }

    if (!_options.ignoreClassName) buffer.writeln(className);

    for (var codeLines in [
      constructorNames,
      fieldNames,
      propertyNames,
      functionNames
    ]) {
      writeCode(codeLines);
    }

    buffer.writeln('}');

    return buffer.toString();
  }

  Iterable<String> _getCodeParts(
      String elementType, Iterable<ElementData> elements) {
    return _getFilteredNames(elements).map((element) =>
        'final String $elementType${element.name.capitalize().privatize()} = \'${element.name}\';');
  }

  Iterable<ElementData> _getFilteredNames(Iterable<ElementData> dataList) {
    return dataList.where((data) => !data.isPrivate && !data.isIgnore);
  }
}
