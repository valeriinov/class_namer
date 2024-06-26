import 'package:class_namer/src/utils/code_processor.dart';
import 'package:class_namer/src/class_namer_visitor.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/utils/options_handler/options_handler.dart';

class ServiceProvider {
  final OptionsHandler _optionsHandler;

  ServiceProvider(this._optionsHandler);

  OptionsHandler getOptionsHandler() => _optionsHandler;

  ClassNamerVisitor createClassNamerVisitor(ClassNamerOptions options) {
    return ImplClassNamerVisitor(options);
  }

  CodeProcessor createCodeProcessor(
      {required ClassNamerVisitor visitor,
      required ClassNamerOptions options}) {
    return ImplCodeProcessor(visitor: visitor, options: options);
  }
}
