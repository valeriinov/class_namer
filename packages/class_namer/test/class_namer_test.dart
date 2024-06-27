import 'dart:io';
import 'package:test/test.dart';

import 'integration/models.dart';

const _generatedFilePath = 'test/integration/models.names.dart';

void main() {
  _setup();

  _names_for_User_model_where_generated_correctly();
  _names_for_User2_model_where_generated_correctly();
  _names_for_User3_model_where_generated_correctly();
  _names_for_InfoMixin_model_where_generated_correctly();
}

void _names_for_User_model_where_generated_correctly() {
  test('Names for the User model were generated correctly', () async {
    expect(User.nameof.fieldName, 'name');
    expect(User.nameof.fieldEmail, 'email');
  });
}

void _names_for_User2_model_where_generated_correctly() {
  test('Names for the User2 model were generated correctly', () async {
    expect(User2.nameof.className, 'User2');

    expect(User2.nameof.constructorTestConstructor, 'testConstructor');

    expect(User2.nameof.fieldName, 'name');
    expect(User2.nameof.fieldEmail, 'email');
    expect(User2.nameof.fieldAddress, 'address');
    expect(User2.nameof.fieldBaseInfo, 'baseInfo');

    expect(User2.nameof.propertyGetPhone, 'phone');
    expect(User2.nameof.propertyGetNameof, 'nameof');

    expect(User2.nameof.functionGetAge, 'getAge');
    expect(User2.nameof.functionGetSecondAddress, 'getSecondAddress');
    expect(User2.nameof.functionToString, 'toString');
  });
}

void _names_for_User3_model_where_generated_correctly() {
  test('Names for the User3 model were generated correctly', () async {
    expect(User3.nameof.fieldName, 'name');
    expect(User3.nameof.propertyGetPhone, 'phone');
  });
}

void _names_for_InfoMixin_model_where_generated_correctly() {
  test('Names for the InfoMixin model were generated correctly', () async {
    expect(InfoMixin.nameof.fieldAddress, 'address');
    expect(InfoMixin.nameof.propertyGetPhone, 'phone');
  });
}

void _setup() {
  setUpAll(() async {
    _invalidateGeneratedFile();

    await _runBuildRunner();

    _testGeneratedFileExist();
  });
}

void _invalidateGeneratedFile() {
  final generatedFile = File(_generatedFilePath);

  if (generatedFile.existsSync()) {
    generatedFile.deleteSync();
  }
}

Future<void> _runBuildRunner() async {
  final result = await Process.run(
      'dart', ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);

  expect(result.exitCode, 0, reason: 'build_runner did not run successfully');
}

void _testGeneratedFileExist() {
  final generatedFile = File(_generatedFilePath);

  expect(generatedFile.existsSync(), isTrue,
      reason: 'Generated file does not exist');
}
