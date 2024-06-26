import 'package:class_namer/src/model/class_namer_options_dto.dart';
import 'package:source_gen/source_gen.dart';

extension ClassNamerOptionsMapper on ConstantReader {
  ClassNamerOptionsDto toClassNamerOptionsDto() {
    final ignoreUtilities = _getOptionValue('ignoreUtilities');
    final ignoreClassName = _getOptionValue('ignoreClassName');
    final ignoreConstructors = _getOptionValue('ignoreConstructors');
    final ignoreMethods = _getOptionValue('ignoreMethods');
    final ignoreFields = _getOptionValue('ignoreFields');
    final ignoreProperties = _getOptionValue('ignoreProperties');

    return ClassNamerOptionsDto(
        ignoreUtilities: ignoreUtilities,
        ignoreClassName: ignoreClassName,
        ignoreConstructors: ignoreConstructors,
        ignoreMethods: ignoreMethods,
        ignoreFields: ignoreFields,
        ignoreProperties: ignoreProperties);
  }

  bool? _getOptionValue(String field) {
    final fieldReader = peek(field);

    if (fieldReader != null && !fieldReader.isNull) {
      return fieldReader.objectValue.toBoolValue();
    }

    return null;
  }
}
