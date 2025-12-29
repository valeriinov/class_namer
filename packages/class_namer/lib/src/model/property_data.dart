import 'element_data.dart';

class PropertyData extends ElementData {
  final bool isSetter;

  String get propertyPrefix => isSetter ? 'Set' : 'Get';

  PropertyData({
    required super.name,
    required super.isPrivate,
    super.isIgnore,
    required this.isSetter,
  });

  factory PropertyData.fromElementData(
    ElementData data, {
    required bool isSetter,
  }) {
    return PropertyData(
      name: data.name,
      isIgnore: data.isIgnore,
      isPrivate: data.isPrivate,
      isSetter: isSetter,
    );
  }
}
