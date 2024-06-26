class ClassNamerOptions {
  final bool ignoreUtilities;
  final bool ignoreClassName;
  final bool ignoreConstructors;
  final bool ignoreMethods;
  final bool ignoreProperties;
  final bool ignoreFields;

  const ClassNamerOptions(
      {this.ignoreUtilities = true,
      this.ignoreClassName = true,
      this.ignoreConstructors = true,
      this.ignoreMethods = true,
      this.ignoreFields = false,
      this.ignoreProperties = false});

  ClassNamerOptions copyWith({
    bool? ignoreUtilities,
    bool? ignoreClassName,
    bool? ignoreConstructors,
    bool? ignoreMethods,
    bool? ignoreProperties,
    bool? ignoreFields,
  }) {
    return ClassNamerOptions(
      ignoreUtilities: ignoreUtilities ?? this.ignoreUtilities,
      ignoreClassName: ignoreClassName ?? this.ignoreClassName,
      ignoreConstructors: ignoreConstructors ?? this.ignoreConstructors,
      ignoreMethods: ignoreMethods ?? this.ignoreMethods,
      ignoreProperties: ignoreProperties ?? this.ignoreProperties,
      ignoreFields: ignoreFields ?? this.ignoreFields,
    );
  }
}
