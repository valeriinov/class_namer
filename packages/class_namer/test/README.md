# Class Namer Tests

To ensure generated files are fresh before testing, always run:

```shell
dart run build_runner test --delete-conflicting-outputs -- -p vm
```

This command rebuilds generated files and runs tests on the Dart VM.

If something goes wrong, clean and retry:

```shell
dart run build_runner clean
```
