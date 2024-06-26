import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// A utility function that creates a [TypeChecker] for the given [type].
TypeChecker _typeChecker(final Type type) => TypeChecker.fromRuntime(type);

/// An extension on [Element] to provide convenient methods for
/// working with annotations.
extension AnnotationManager on Element {
  /// Whether the element has an annotation of the specified [type].
  ///
  /// The [type] parameter specifies the type of the annotation to look for.
  bool hasAnnotation(final Type type) {
    return _typeChecker(type).hasAnnotationOfExact(this);
  }

  /// Retrieves the first annotation of the specified [type] from the element.
  ///
  /// The [type] parameter specifies the type of the annotation to retrieve.
  ///
  /// Returns a [DartObject] representing the annotation if found,
  /// otherwise `null`.
  DartObject? getAnnotation(final Type type) {
    return _typeChecker(type).firstAnnotationOfExact(this);
  }
}
