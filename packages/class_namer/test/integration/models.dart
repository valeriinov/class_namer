import 'package:class_namer_annotation/class_namer_annotation.dart';

part 'models.names.dart';

@ClassNamer()
class User {
  final String name;
  final String email;

  String get phone => '';

  int getAge() => -1;

  const User(this.name, this.email);

  static UserNames get nameof => UserNames._();
}

@ClassNamer(
  ignoreClassName: false,
  ignoreMethods: false,
  ignoreProperties: false,
  ignoreConstructors: false,
  ignoreUtilities: false,
)
class User2 extends UserBase with InfoMixin2 {
  final String name;
  final String email;

  String get phone => '';

  int getAge() => -1;

  User2(this.name, this.email);

  User2.testConstructor(this.name, this.email);

  static User2Names get nameof => User2Names._();
}

class UserBase {
  final String baseInfo;

  UserBase({this.baseInfo = ''});
}

mixin InfoMixin2 {
  final String address = '';

  String getSecondAddress() => '';
}

@ClassNamer()
class User3 {
  final String name;
  @classNamerIgnore
  final String email;

  String get phone => '';

  int getAge() => -1;

  const User3(this.name, this.email);

  static User3Names get nameof => User3Names._();
}

@ClassNamer()
mixin InfoMixin {
  final String address = '';

  String get phone => '';

  @classNamerIgnore
  final String email = '';

  String getSecondAddress() => '';

  static InfoMixinNames get nameof => InfoMixinNames._();
}
