import 'package:analyzer/dart/element/element.dart';

/// An extension on [String] to provide utility methods for handling element data.
extension ElementDataHandler on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Returns an empty string if the original string is empty.
  String capitalize() {
    if (isEmpty) return '';

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Removes the leading underscore and capitalizes the first
  /// letter of the resulting string.
  ///
  /// If the string does not start with an underscore,
  /// it returns the original string.
  String privatize() {
    if (isNotEmpty && this[0] == '_') {
      return substring(1).capitalize();
    }

    return this;
  }

  /// Removes service symbols from the [Element] name string.
  ///
  /// Useful for cleaning up element names that may contain
  /// service symbols from certain code transformations.
  String cleanNameFromServiceSymbols() => replaceAll('=', '');

  /// Removes service symbols from the [Element] type string.
  ///
  /// Useful for cleaning up type names that may contain
  /// service symbols from certain code transformations.
  String cleanTypeFromServiceSymbols() => replaceAll('*', '');
}

/// Joins an iterable of strings into a single string with each
/// element separated by a newline.
///
/// The [codeArray] parameter is the iterable of strings to join.
///
/// Returns a single string with each element from the
/// iterable separated by a newline.
String join(Iterable<String> codeArray) => codeArray.join('\n');
