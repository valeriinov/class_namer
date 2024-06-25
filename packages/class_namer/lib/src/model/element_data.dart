class ElementData {
  final String name;
  final bool isPrivate;
  final bool isIgnore;

  ElementData(
      {required this.name, required this.isPrivate, this.isIgnore = false});
}
