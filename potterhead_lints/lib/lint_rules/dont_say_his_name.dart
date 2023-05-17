import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// A regex to check if Voldemort's name is mentioned in a string
final _voldemortRegex = RegExp(
  r'voldemort|\b(tom(?:[\s-]*marvolo)?[\s-]*riddle)\b',
  caseSensitive: false,
);

// Lint rule to not mention Voldemort in a variable's name
class DontSayHisName extends DartLintRule {
  DontSayHisName() : super(code: _code);

  // Lint rule metadata
  static const _code = LintCode(
    name: 'dont_say_his_name',
    problemMessage: 'His name shall not be mentioned',
  );

  // `run` is where you analyze a file and report lint errors
  // Invoked on a file automatically
  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // A call back fn that runs on all variable declarations in a file
    context.registry.addVariableDeclaration((node) {
      final element = node.declaredElement;
      // `return` if the regex doesn't find a match
      if (element == null || !_voldemortRegex.hasMatch(element.name)) return;

      // report a lint error with the `code` and the respective `element`
      reporter.reportErrorForElement(code, element);
    });
  }

  // Possible fixes for the lint error go here
  @override
  List<Fix> getFixes() => [_ReplaceHisName()];
}

// Fix that replaces Voldermort's name with another string
class _ReplaceHisName extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    // Callback fn that runs on every variable declaration in a file
    context.registry.addVariableDeclaration((node) {
      final element = node.declaredElement;

      // `return` if the current variable declaration is not where the lint
      // error has appeared
      if (element == null ||
          !analysisError.sourceRange.intersects(node.sourceRange)) return;

      // Create a `ChangeBuilder` instance to do file operations with an action
      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace his name',
        priority: 1,
      );
      // Use the `changeBuilder` to make Dart file edits
      changeBuilder.addDartFileEdit((builder) {
        // Use the `builder` to replace the variable name
        builder.addSimpleReplacement(
          SourceRange(element.nameOffset, element.nameLength),
          // the string to be replaced instead of variable name
          element.name.replaceAll(
            _voldemortRegex,
            "HeWhoMustNotBeNamed",
          ),
        );
      });
    });
  }
}
