# Class Namer

In some cases, you need access to the textual representation of class member names. However,
standard language features do not provide a way to retrieve these names directly. This is where the
class_namer package comes in. By using code generation, class_namer automatically creates classes
containing the names of your class members, making it easy to access these names programmatically.

## Getting started

To use `Class Namer` you will need your
typical [build_runner](https://pub.dev/packages/build_runner) code-generator setup. Follow these
steps:

1. Install [build_runner](https://pub.dev/packages/build_runner).
2. Add `class_namer` as a dev dependency and `class_namer_annotation` as a dependency
   [in your pubspec.yaml file](https://docs.flutter.dev/packages-and-plugins/using-packages).
3. Run `flutter pub get` to install the package.

## Usage

1. Annotate your classes with @ClassNamer to generate a corresponding names class.
2. Run the following command to generate the names classes:

```shell
dart run build_runner build
```

```dart
import 'package:class_namer_annotation/class_namer_annotation.dart';

part 'user.names.dart';

@ClassNamer()
class User {
  final String name;
  final String email;

  int get age => 20;

  const User(this.name, this.email);

  static UserNames get nameof => UserNames._();
}
```

This will generate a class UserNames with the names of the fields:

```dart
part of 'user.dart';

class UserNames {
  UserNames._();

  final String fieldName = 'name';
  final String fieldEmail = 'email';

  final String propertyGetAge = 'age';
}
```

You can then access the names of the class members in your code:

```dart
main() {
  print(User.nameof.fieldName); // name
  print(User.nameof.propertyGetAge); // age
}
```

Configuration Options:

- `includeMixinsMembers`: Whether to include members from mixins in the generated class names.
  Default is true.
- `includeSuperMembers`: Whether to include members from superclasses in the generated class names.
  Default is true.
- `ignoreUtilities`: Whether to ignore utility functions (e.g., copyWith, toJson). Default is true.
- `ignoreClassName`: Whether to ignore the class name. Default is true.
- `ignoreConstructors`: Whether to ignore constructors. Default is true.
- `ignoreMethods`: Whether to ignore methods. Default is true.
- `ignoreFields`: Whether to ignore fields. Default is false.
- `ignoreProperties`: Whether to ignore properties. Default is false.

## Ignoring Elements

You can configure the @ClassNamer annotation to ignore specific elements:

```dart
import 'package:class_namer_annotation/class_namer_annotation.dart';

part 'user.names.dart';

@ClassNamer(ignoreProperties: true)
class User {
  final String name;
  final String email;

  int get age => 20;

  const User(this.name, this.email);

  static UserNames get nameof => UserNames._();
}
```

Or use the @classNamerIgnore annotation to ignore specific fields or methods:

```dart
import 'package:class_namer_annotation/class_namer_annotation.dart';

part 'user.names.dart';

@ClassNamer()
class User {
  final String name;
  final String email;

  @classNamerIgnore
  int get age => 20;

  const User(this.name, this.email);

  static UserNames get nameof => UserNames._();
}
```

The result will be:

```dart
part of 'user.dart';

class UserNames {
  UserNames._();

  final String fieldName = 'name';
  final String fieldEmail = 'email';
}
```

## Global Configuration

You can apply global settings for your project by creating a build.yaml file in the root of your
project with the following content:

```yaml
targets:
  $default:
    builders:
      class_namer:
        options:
          includeMixinsMembers: true
          includeSuperMembers: true
          ignoreUtilities: false
          ignoreConstructors: false
          ignoreClassName: false
          ignoreMethods: false
          ignoreFields: false
          ignoreProperties: false
```



