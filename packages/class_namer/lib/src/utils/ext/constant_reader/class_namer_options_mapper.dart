import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:source_gen/source_gen.dart';

extension ClassNamerOptionsMapper on ConstantReader {
  ClassNamerOptions toClassNamerOptions() {
    final ignoreUtilities = _getOptionValue('ignoreUtilities');
    final ignoreClassName = _getOptionValue('ignoreClassName');
    final ignoreConstructors = _getOptionValue('ignoreConstructors');
    final ignoreMethods = _getOptionValue('ignoreMethods');
    final ignoreFields = _getOptionValue('ignoreFields');
    final ignoreProperties = _getOptionValue('ignoreProperties');

    const options = ClassNamerOptions();

    return options.copyWith(
        ignoreUtilities: ignoreUtilities,
        ignoreClassName: ignoreClassName,
        ignoreConstructors: ignoreConstructors,
        ignoreMethods: ignoreMethods,
        ignoreFields: ignoreFields,
        ignoreProperties: ignoreProperties);
  }

  bool? _getOptionValue(String field) {
    return read(field).objectValue.toBoolValue();
  }
}
