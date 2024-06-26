extension UtilityNameValidator on String {
  bool get isUtilityName {
    return this == 'copyWith' ||
        this == 'toJson' ||
        this == 'fromJson' ||
        this == 'nameof' ||
        this == 'toMap' ||
        this == 'fromMap';
  }
}
