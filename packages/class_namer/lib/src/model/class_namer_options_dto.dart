class ClassNamerOptionsDto {
  final bool? ignoreUtilities;
  final bool? ignoreClassName;
  final bool? ignoreConstructors;
  final bool? ignoreMethods;
  final bool? ignoreProperties;
  final bool? ignoreFields;

  const ClassNamerOptionsDto(
      {this.ignoreUtilities,
      this.ignoreClassName,
      this.ignoreConstructors,
      this.ignoreMethods,
      this.ignoreFields,
      this.ignoreProperties});

  factory ClassNamerOptionsDto.fromMap(Map<String, dynamic> map) {
    return ClassNamerOptionsDto(
      ignoreUtilities: map['ignoreUtilities'],
      ignoreClassName: map['ignoreClassName'],
      ignoreConstructors: map['ignoreConstructors'],
      ignoreMethods: map['ignoreMethods'],
      ignoreProperties: map['ignoreProperties'],
      ignoreFields: map['ignoreFields'],
    );
  }

  ClassNamerOptionsDto copyWithOptionsDto(ClassNamerOptionsDto options) {
    return copyWith(
        ignoreUtilities: options.ignoreUtilities,
        ignoreClassName: options.ignoreClassName,
        ignoreConstructors: options.ignoreConstructors,
        ignoreMethods: options.ignoreMethods,
        ignoreProperties: options.ignoreProperties,
        ignoreFields: options.ignoreFields);
  }

  ClassNamerOptionsDto copyWith({
    bool? ignoreUtilities,
    bool? ignoreClassName,
    bool? ignoreConstructors,
    bool? ignoreMethods,
    bool? ignoreProperties,
    bool? ignoreFields,
  }) {
    return ClassNamerOptionsDto(
      ignoreUtilities: ignoreUtilities ?? this.ignoreUtilities,
      ignoreClassName: ignoreClassName ?? this.ignoreClassName,
      ignoreConstructors: ignoreConstructors ?? this.ignoreConstructors,
      ignoreMethods: ignoreMethods ?? this.ignoreMethods,
      ignoreProperties: ignoreProperties ?? this.ignoreProperties,
      ignoreFields: ignoreFields ?? this.ignoreFields,
    );
  }
}
