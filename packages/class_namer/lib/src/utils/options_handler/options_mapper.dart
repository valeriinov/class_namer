import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/class_namer_options_dto.dart';
import 'package:source_gen/source_gen.dart';

class OptionsMapper {
  ClassNamerOptionsDto mapConstantReaderToClassNamerOptionsDto(
      ConstantReader reader) {
    final ignoreUtilities = _getOptionValue('ignoreUtilities', reader);
    final ignoreClassName = _getOptionValue('ignoreClassName', reader);
    final ignoreConstructors = _getOptionValue('ignoreConstructors', reader);
    final ignoreMethods = _getOptionValue('ignoreMethods', reader);
    final ignoreFields = _getOptionValue('ignoreFields', reader);
    final ignoreProperties = _getOptionValue('ignoreProperties', reader);

    return ClassNamerOptionsDto(
        ignoreUtilities: ignoreUtilities,
        ignoreClassName: ignoreClassName,
        ignoreConstructors: ignoreConstructors,
        ignoreMethods: ignoreMethods,
        ignoreFields: ignoreFields,
        ignoreProperties: ignoreProperties);
  }

  bool? _getOptionValue(String fieldName, ConstantReader reader) {
    final fieldReader = reader.peek(fieldName);

    if (fieldReader != null && !fieldReader.isNull) {
      return fieldReader.objectValue.toBoolValue();
    }

    return null;
  }

  ClassNamerOptions mapClassNameOptionsDtoToClassNameOptions(
      ClassNamerOptionsDto dto) {
    const defaultOptions = ClassNamerOptions();

    return defaultOptions.copyWith(
        ignoreUtilities: dto.ignoreUtilities,
        ignoreClassName: dto.ignoreClassName,
        ignoreConstructors: dto.ignoreConstructors,
        ignoreMethods: dto.ignoreMethods,
        ignoreProperties: dto.ignoreProperties,
        ignoreFields: dto.ignoreFields);
  }
}
