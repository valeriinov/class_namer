import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/class_namer_options_dto.dart';
import 'package:class_namer/src/utils/options_handler/options_mapper.dart';

import 'package:source_gen/source_gen.dart';

class OptionsHandler {
  final Map<String, dynamic> _initConfig;
  final OptionsMapper _mapper;

  OptionsHandler(
      {required Map<String, dynamic> initConfig, required OptionsMapper mapper})
      : _initConfig = initConfig,
        _mapper = mapper;

  ClassNamerOptions getOptions(ConstantReader annotation) {
    final initOptionsDto = ClassNamerOptionsDto.fromMap(_initConfig);

    final annotationOptionsDto =
        _mapper.mapConstantReaderToClassNamerOptionsDto(annotation);

    final optionsDto = initOptionsDto.copyWithOptionsDto(annotationOptionsDto);

    return _mapper.mapClassNameOptionsDtoToClassNameOptions(optionsDto);
  }
}
