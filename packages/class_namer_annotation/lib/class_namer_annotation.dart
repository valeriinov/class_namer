library class_namer_annotation;

class ClassNamer {
  final bool ignoreUtilities;
  final bool ignoreClassName;
  final bool ignoreConstructors;
  final bool ignoreMethods;
  final bool ignoreProperties;
  final bool ignoreFields;

  const ClassNamer(
      {this.ignoreUtilities = true,
      this.ignoreClassName = true,
      this.ignoreConstructors = true,
      this.ignoreMethods = true,
      this.ignoreFields = false,
      this.ignoreProperties = false});
}

class ClassNamerIgnore {
  const ClassNamerIgnore();
}

const classNamer = ClassNamer();

const classNamerIgnore = ClassNamerIgnore();
