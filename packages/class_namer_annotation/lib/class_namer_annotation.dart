library class_namer_annotation;

/// An annotation used to configure class naming options.
///
/// Example:
/// ```dart
/// import 'package:class_namer_annotation/class_namer_annotation.dart';
///
/// part 'user.names.dart';
///
/// @ClassNamer(ignoreUtilities: false)
/// class User {
///   final String name;
///   final String email;
///
///   const User(this.name, this.email);
///
///   static UserNames get nameof => UserNames._();
/// }
/// ```
class ClassNamer {
  /// Whether to ignore utility functions (e.g., `copyWith`, `toJson`).
  ///
  /// The default value is `true`.
  final bool? ignoreUtilities;

  /// Whether to ignore the class name.
  ///
  /// The default value is `true`.
  final bool? ignoreClassName;

  /// Whether to ignore constructors.
  ///
  /// The default value is `true`.
  final bool? ignoreConstructors;

  /// Whether to ignore methods.
  ///
  /// The default value is `true`.
  final bool? ignoreMethods;

  /// Whether to ignore properties.
  ///
  /// The default value is `false`.
  final bool? ignoreProperties;

  /// Whether to ignore fields.
  ///
  /// The default value is `false`.
  final bool? ignoreFields;

  /// Creates an instance of [ClassNamer] with the given configuration options.
  const ClassNamer(
      {this.ignoreUtilities,
      this.ignoreClassName,
      this.ignoreConstructors,
      this.ignoreMethods,
      this.ignoreFields,
      this.ignoreProperties});
}

/// An annotation used to mark a class, method, or field to be ignored by naming.
///
/// Example:
/// ```dart
/// import 'package:class_namer_annotation/class_namer_annotation.dart';
///
/// part 'user.names.dart';
///
/// @ClassNamer(ignoreUtilities: false)
/// class User {
///   @ClassNamerIgnore()
///   final String name;
///   final String email;
///
///   const User(this.name, this.email);
///
///   static UserNames get nameof => UserNames._();
/// }
/// ```
class ClassNamerIgnore {
  const ClassNamerIgnore();
}

/// A constant instance of [ClassNamer] for convenient use.
///
/// Example:
/// ```dart
/// import 'package:class_namer_annotation/class_namer_annotation.dart';
///
/// part 'user.names.dart';
///
/// @сlassNamer
/// class User {
///   final String name;
///   final String email;
///
///   const User(this.name, this.email);
///
///   static UserNames get nameof => UserNames._();
/// }
/// ```
const classNamer = ClassNamer();

/// A constant instance of [ClassNamerIgnore] for convenient use.
///
/// Example:
/// ```dart
/// import 'package:class_namer_annotation/class_namer_annotation.dart';
///
/// part 'user.names.dart';
///
/// @сlassNamer
/// class User {
///   @classNamerIgnore
///   final String name;
///   final String email;
///
///   const User(this.name, this.email);
///
///   static UserNames get nameof => UserNames._();
/// }
/// ```
const classNamerIgnore = ClassNamerIgnore();
