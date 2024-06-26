import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/class_namer_options_dto.dart';

extension OptionsMapper on ClassNamerOptionsDto {
  ClassNamerOptions toClassNamerOptions() {
    const defaultOptions = ClassNamerOptions();

    return defaultOptions.copyWith(
        ignoreUtilities: ignoreUtilities,
        ignoreClassName: ignoreClassName,
        ignoreConstructors: ignoreConstructors,
        ignoreMethods: ignoreMethods,
        ignoreProperties: ignoreProperties,
        ignoreFields: ignoreFields);
  }
}
