import 'package:class_namer_annotation/class_namer_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [User] class
class UserNames {
  UserNames._();

  final String fieldName = 'name';
  final String fieldEmail = 'email';
}
''')
@classNamer
class User {
  final String name;
  final String email;

  User(this.name, this.email);
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [User2] class
class User2Names {
  User2Names._();

  final String fieldName = 'name';
  final String fieldEmail = 'email';
  final String fieldAddress = 'address';

  final String propertyGetAge = 'age';

  final String functionGetSecondAddress = 'getSecondAddress';
}
''')
@ClassNamer(ignoreMethods: false)
class User2 with InfoMixin {
  final String name;
  final String email;

  User2(this.name, this.email);
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [User3] class
class User3Names {
  User3Names._();

  final String fieldAddress = 'address';
  final String fieldName = 'name';
  final String fieldEmail = 'email';

  final String propertyGetAge = 'age';
}
''')
@ClassNamer()
class User3 extends SuperUser with InfoMixin {
  User3(super.name, super.email);
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [User4] class
class User4Names {
  User4Names._();

  final String fieldPhone = 'phone';
  final String fieldName = 'name';
  final String fieldEmail = 'email';
}
''')
@ClassNamer(includeMixinsMembers: false)
class User4 extends SuperUser with InfoMixin {
  final String phone = '';

  User4(super.name, super.email);
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [User5] class
class User5Names {
  User5Names._();

  final String fieldPhone = 'phone';
}
''')
@ClassNamer(includeMixinsMembers: false, includeSuperMembers: false)
class User5 extends SuperUser with InfoMixin {
  final String phone = '';

  User5(super.name, super.email);
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [User7] class
class User7Names {
  User7Names._();

  final String className = 'User7';

  final String fieldPhone = 'phone';
  final String fieldAddress = 'address';
  final String fieldName = 'name';
  final String fieldEmail = 'email';

  final String propertyGetAge = 'age';
  final String propertyGetHashCode = 'hashCode';
  final String propertyGetRuntimeType = 'runtimeType';

  final String functionGetSecondAddress = 'getSecondAddress';
  final String functionToString = 'toString';
  final String functionNoSuchMethod = 'noSuchMethod';
  final String functionHash = 'hash';
  final String functionHashAll = 'hashAll';
  final String functionHashAllUnordered = 'hashAllUnordered';
}
''')
@ClassNamer(
    includeMixinsMembers: true,
    includeSuperMembers: true,
    ignoreUtilities: false,
    ignoreClassName: false,
    ignoreConstructors: false,
    ignoreMethods: false,
    ignoreFields: false,
    ignoreProperties: false)
class User7 extends SuperUser with InfoMixin {
  final String phone = '';

  User7(super.name, super.email);
}

class SuperUser {
  final String name;
  final String email;

  SuperUser(this.name, this.email);
}

mixin InfoMixin {
  final String address = '';

  int get age => -1;

  String getSecondAddress() => '';
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [User8] class
class User8Names {
  User8Names._();

  final String fieldName = 'name';
}
''')
@ClassNamer()
class User8 {
  final String name;
  @classNamerIgnore
  final String email;

  User8(this.name, this.email);
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [InfoMixin2] class
class InfoMixin2Names {
  InfoMixin2Names._();

  final String fieldAddress = 'address';

  final String propertyGetAge = 'age';
}
''')
@ClassNamer()
mixin InfoMixin2 {
  final String address = '';

  int get age => -1;

  String getSecondAddress() => '';
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [InfoMixin3] class
class InfoMixin3Names {
  InfoMixin3Names._();

  final String fieldAddress = 'address';

  final String functionGetSecondAddress = 'getSecondAddress';
}
''')
@ClassNamer(ignoreMethods: false)
mixin InfoMixin3 {
  final String address = '';

  @classNamerIgnore
  int get age => -1;

  String getSecondAddress() => '';
}
