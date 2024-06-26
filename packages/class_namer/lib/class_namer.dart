library class_namer;

import 'package:build/build.dart';
import 'package:class_namer/src/class_namer_generator.dart';
import 'package:class_namer/src/utils/service_provider.dart';
import 'package:class_namer/src/utils/options_handler/options_handler.dart';
import 'package:class_namer/src/utils/options_handler/options_mapper.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder classNamer(BuilderOptions options) {
  final mapper = OptionsMapper();
  final optionsHandler =
      OptionsHandler(initConfig: options.config, mapper: mapper);
  final serviceProvider = ServiceProvider(optionsHandler);

  return PartBuilder(
    [ClassNamerGenerator(serviceProvider)],
    '.names.dart',
    options: options,
  );
}
