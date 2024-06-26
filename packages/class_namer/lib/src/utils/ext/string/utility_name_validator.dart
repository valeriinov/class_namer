/// An extension on [String] to provide a utility method for validating
/// if a string is a common utility name.
extension UtilityNameValidator on String {
  /// Whether the string is a common utility name.
  ///
  /// Common utility names include:
  /// - `copyWith`
  /// - `toJson`
  /// - `fromJson`
  /// - `nameof`
  /// - `toMap`
  /// - `fromMap`
  ///
  /// Returns `true` if the string is one of the common utility names,
  /// otherwise returns `false`.
  bool get isUtilityName {
    return this == 'copyWith' ||
        this == 'toJson' ||
        this == 'fromJson' ||
        this == 'nameof' ||
        this == 'toMap' ||
        this == 'fromMap';
  }
}
