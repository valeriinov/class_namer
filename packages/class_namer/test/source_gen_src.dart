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
