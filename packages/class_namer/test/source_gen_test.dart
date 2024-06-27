import 'package:class_namer/src/class_namer_generator.dart';
import 'package:class_namer/src/utils/options_handler/options_handler.dart';
import 'package:class_namer/src/utils/options_handler/options_mapper.dart';
import 'package:class_namer/src/utils/service_provider.dart';
import 'package:class_namer_annotation/class_namer_annotation.dart';
import 'package:source_gen_test/source_gen_test.dart';


Future<void> main() async {
  final reader =
      await initializeLibraryReaderForDirectory('test', 'source_gen_src.dart');

  initializeBuildLogTracking();

  final mapper = OptionsMapper();
  final optionsHandler = OptionsHandler(initConfig: {}, mapper: mapper);
  final serviceProvider = ServiceProvider(optionsHandler);

  testAnnotatedElements<ClassNamer>(
      reader, ClassNamerGenerator(serviceProvider));
}
