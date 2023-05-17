// ignore_for_file: unused_local_variable
import 'package:custom_lint_example/HelloService.dart';
import 'package:custom_lint_example/Utils.dart';

void main() {
  // remove the next line.
  // expect_lint: dont_say_his_name
  var cuteLilVoldemort = "the wizard of mystery";

  // place your cursor on the string literal and `ctrl + .`
  // in VSCode (or whatever shortcut your IDE supports for assist actions)
  // then, choose 'Insert a random spell in the string literal'.
  var randomString = "sfgsdnkgj";

  // navigate to the `AuthService` and check it out.
  final auth = AuthService();

  // navigate to the `Utils` and check it out.
  Utils.hi();
}
