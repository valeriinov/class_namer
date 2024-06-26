import 'package:class_namer/src/utils/code_processor.dart';
import 'package:class_namer/src/class_namer_visitor.dart';
import 'package:class_namer/src/model/class_namer_options.dart';
import 'package:class_namer/src/utils/options_handler/options_handler.dart';

/// A service provider class that offers various services required for class naming
/// and code processing.
class ServiceProvider {
  final OptionsHandler _optionsHandler;

  /// Constructs a [ServiceProvider] with the given [OptionsHandler].
  ///
  /// The [optionsHandler] parameter is used to handle configuration options.
  ServiceProvider(this._optionsHandler);

  /// Returns the [OptionsHandler] instance.
  OptionsHandler getOptionsHandler() => _optionsHandler;

  /// Creates and returns an instance of [ClassNamerVisitor] with
  /// the provided [ClassNamerOptions].
  ///
  /// The [options] parameter specifies the configuration
  /// options for class naming.
  ClassNamerVisitor createClassNamerVisitor(ClassNamerOptions options) {
    return ImplClassNamerVisitor(options);
  }

  /// Creates and returns an instance of [CodeProcessor] with the
  /// provided visitor and options.
  ///
  /// The [visitor] parameter is an instance of [ClassNamerVisitor] that
  /// visits class elements.
  ///
  /// The [options] parameter specifies the configuration
  /// options for class naming.
  CodeProcessor createCodeProcessor(
      {required ClassNamerVisitor visitor,
      required ClassNamerOptions options}) {
    return ImplCodeProcessor(visitor: visitor, options: options);
  }
}
