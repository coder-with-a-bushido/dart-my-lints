# My Lints

An example on building dart custom lints with `custom_lint` package. 

Check out the blog [Custom lints for your Dart/Flutter project](https://coder-with-a-bushido.medium.com/custom-lints-for-your-dart-flutter-project-9447a596c1f0) to understand how this was built.

## Lint Rules
1. `dont_say_his_name` 
-> Voldemort's name shouldn't be mentioned in a variable name
2. `util_methods_be_static`
-> All methods in a `Utils` class must be `static`
3. `one_service_class_per_file`
-> Only one `Service` class allowed per file

## Assists
1. Insert a random spell in the string literal

