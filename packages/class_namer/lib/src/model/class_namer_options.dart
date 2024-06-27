class ClassNamerOptions {
  final bool includeMixinsMembers;
  final bool includeSuperMembers;
  final bool ignoreUtilities;
  final bool ignoreClassName;
  final bool ignoreConstructors;
  final bool ignoreMethods;
  final bool ignoreProperties;
  final bool ignoreFields;

  const ClassNamerOptions(
      {this.includeMixinsMembers = true,
      this.includeSuperMembers = true,
      this.ignoreUtilities = true,
      this.ignoreClassName = true,
      this.ignoreConstructors = true,
      this.ignoreMethods = true,
      this.ignoreFields = false,
      this.ignoreProperties = false});

  ClassNamerOptions copyWith({
    bool? includeMixinsMembers,
    bool? includeSuperMembers,
    bool? ignoreUtilities,
    bool? ignoreClassName,
    bool? ignoreConstructors,
    bool? ignoreMethods,
    bool? ignoreProperties,
    bool? ignoreFields,
  }) {
    return ClassNamerOptions(
      includeMixinsMembers: includeMixinsMembers ?? this.includeMixinsMembers,
      includeSuperMembers: includeSuperMembers ?? this.includeSuperMembers,
      ignoreUtilities: ignoreUtilities ?? this.ignoreUtilities,
      ignoreClassName: ignoreClassName ?? this.ignoreClassName,
      ignoreConstructors: ignoreConstructors ?? this.ignoreConstructors,
      ignoreMethods: ignoreMethods ?? this.ignoreMethods,
      ignoreProperties: ignoreProperties ?? this.ignoreProperties,
      ignoreFields: ignoreFields ?? this.ignoreFields,
    );
  }
}
