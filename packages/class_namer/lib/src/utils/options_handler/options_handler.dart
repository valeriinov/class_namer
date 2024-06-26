import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/class_namer_options_dto.dart';
import 'package:class_namer/src/utils/options_handler/options_mapper.dart';

import 'package:source_gen/source_gen.dart';

/// A class responsible for handling and merging configuration options from
/// both build.yaml and annotation.
class OptionsHandler {
  final Map<String, dynamic> _initConfig;
  final OptionsMapper _mapper;

  /// Constructs an [OptionsHandler] with the given initial configuration
  /// and an options mapper.
  ///
  /// The [initConfig] parameter provides the initial configuration options
  /// from build.yaml.
  ///
  /// The [mapper] parameter is an instance of [OptionsMapper] to handle the
  /// mapping of options.
  OptionsHandler(
      {required Map<String, dynamic> initConfig, required OptionsMapper mapper})
      : _initConfig = initConfig,
        _mapper = mapper;

  /// Retrieves and merges configuration options from build.yaml and annotation.
  ///
  /// The [annotation] parameter provides the options specified in the
  /// annotation.
  ///
  /// The options from the build.yaml configuration are overwritten by
  /// the options specified in the annotation.
  ClassNamerOptions getOptions(ConstantReader annotation) {
    // Options from build.yaml.
    final initOptionsDto = ClassNamerOptionsDto.fromMap(_initConfig);

    // Options from annotation.
    final annotationOptionsDto =
        _mapper.mapConstantReaderToClassNamerOptionsDto(annotation);

    // Merge options, annotation overrides build.yaml.
    final optionsDto = initOptionsDto.copyWithOptionsDto(annotationOptionsDto);

    // Apply default values for unset parameters.
    return _mapper.mapClassNameOptionsDtoToClassNameOptions(optionsDto);
  }
}
