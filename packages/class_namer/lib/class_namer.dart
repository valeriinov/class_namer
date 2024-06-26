library class_namer;

import 'package:build/build.dart';
import 'package:class_namer/src/class_namer_generator.dart';
import 'package:class_namer/src/model/class_namer_options_dto.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder classNamer(BuilderOptions options) {
  return PartBuilder(
    [ClassNamerGenerator(ClassNamerOptionsDto.fromMap(options.config))],
    '.names.dart',
    options: options,
  );
}
