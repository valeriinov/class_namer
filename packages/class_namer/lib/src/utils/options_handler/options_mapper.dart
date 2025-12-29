import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/model/class_namer_options_dto.dart';
import 'package:source_gen/source_gen.dart';

/// A class responsible for mapping configuration options
class OptionsMapper {
  /// Maps configuration options from [ConstantReader] to [ClassNamerOptionsDto].
  ///
  /// The [reader] parameter is used to read the annotation values.
  ///
  /// Returns a [ClassNamerOptionsDto] containing the mapped options.
  ClassNamerOptionsDto mapConstantReaderToClassNamerOptionsDto(
    ConstantReader reader,
  ) {
    final includeMixinsMembers = _getOptionValue(
      'includeMixinsMembers',
      reader,
    );
    final includeSuperMembers = _getOptionValue('includeSuperMembers', reader);
    final ignoreUtilities = _getOptionValue('ignoreUtilities', reader);
    final ignoreClassName = _getOptionValue('ignoreClassName', reader);
    final ignoreConstructors = _getOptionValue('ignoreConstructors', reader);
    final ignoreMethods = _getOptionValue('ignoreMethods', reader);
    final ignoreFields = _getOptionValue('ignoreFields', reader);
    final ignoreProperties = _getOptionValue('ignoreProperties', reader);

    return ClassNamerOptionsDto(
      includeMixinsMembers: includeMixinsMembers,
      includeSuperMembers: includeSuperMembers,
      ignoreUtilities: ignoreUtilities,
      ignoreClassName: ignoreClassName,
      ignoreConstructors: ignoreConstructors,
      ignoreMethods: ignoreMethods,
      ignoreFields: ignoreFields,
      ignoreProperties: ignoreProperties,
    );
  }

  bool? _getOptionValue(String fieldName, ConstantReader reader) {
    final fieldReader = reader.peek(fieldName);

    if (fieldReader != null && !fieldReader.isNull) {
      return fieldReader.objectValue.toBoolValue();
    }

    return null;
  }

  /// Maps [ClassNamerOptionsDto] to [ClassNamerOptions],
  /// applying default values where necessary.
  ///
  /// The [dto] parameter is the data transfer object
  /// containing the configuration options.
  ///
  /// Returns a [ClassNamerOptions] instance with the mapped options.
  ClassNamerOptions mapClassNameOptionsDtoToClassNameOptions(
    ClassNamerOptionsDto dto,
  ) {
    const defaultOptions = ClassNamerOptions();

    return defaultOptions.copyWith(
      includeMixinsMembers: dto.includeMixinsMembers,
      includeSuperMembers: dto.includeSuperMembers,
      ignoreUtilities: dto.ignoreUtilities,
      ignoreClassName: dto.ignoreClassName,
      ignoreConstructors: dto.ignoreConstructors,
      ignoreMethods: dto.ignoreMethods,
      ignoreProperties: dto.ignoreProperties,
      ignoreFields: dto.ignoreFields,
    );
  }
}
