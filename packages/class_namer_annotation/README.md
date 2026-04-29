# class_namer_annotation

Annotations used by the `class_namer` generator.

Add this package to the regular `dependencies` section of your `pubspec.yaml`.
Use `class_namer` itself as a dev dependency because it runs during code generation.

```yaml
dependencies:
  class_namer_annotation:
    git:
      url: https://github.com/valeriinov/class_namer.git
      path: packages/class_namer_annotation
      ref: 0.2.0
```

Import the annotations from your model file:

```dart
import 'package:class_namer_annotation/class_namer_annotation.dart';
```

Use `@ClassNamer()` or the `@classNamer` constant on classes and mixins. Use
`@classNamerIgnore` to exclude a member from generated names.
