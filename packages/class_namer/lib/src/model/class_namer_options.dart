class ClassNamerOptions {
  final bool ignoreClassName;
  final bool ignoreConstructors;
  final bool ignoreMethods;
  final bool ignoreProperties;
  final bool ignoreFields;

  const ClassNamerOptions(
      {this.ignoreClassName = true,
      this.ignoreConstructors = true,
      this.ignoreMethods = true,
      this.ignoreFields = false,
      this.ignoreProperties = false});
}
