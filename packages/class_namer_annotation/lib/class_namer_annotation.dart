library class_namer_annotation;

class ClassNamer {
  final bool? ignoreUtilities;
  final bool? ignoreClassName;
  final bool? ignoreConstructors;
  final bool? ignoreMethods;
  final bool? ignoreProperties;
  final bool? ignoreFields;

  const ClassNamer(
      {this.ignoreUtilities,
      this.ignoreClassName,
      this.ignoreConstructors,
      this.ignoreMethods,
      this.ignoreFields,
      this.ignoreProperties});
}

class ClassNamerIgnore {
  const ClassNamerIgnore();
}

const classNamer = ClassNamer();

const classNamerIgnore = ClassNamerIgnore();
