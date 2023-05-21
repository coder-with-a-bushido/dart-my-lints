import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// Lint rule to make sure all `Utils` methods are static
class UtilMethodsBeStatic extends DartLintRule {
  UtilMethodsBeStatic() : super(code: _code);

  // Lint rule metadata
  static const _code = LintCode(
    name: 'util_methods_be_static',
    problemMessage: 'Methods of Utils class should be static',
  );

  // `run` is where you analyze a file and report lint errors
  // Invoked on a file automatically on every file edit
  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // A call back fn that runs on all class declarations in a file
    context.registry.addClassDeclaration(
      (node) {
        final element = node.declaredElement;
        // `return` if class name doesn't end with "Utils"
        if (element == null || !element.name.endsWith("Utils")) {
          return;
        }
        // iterate over all methods of the class
        for (var method in element.methods) {
          // if the method is `static`
          if (!method.isStatic) {
            // report a lint error with the `code` and the respective method
            reporter.reportErrorForElement(code, method);
          }
        }
      },
    );
  }

  // Possible fixes for the lint error go here
  @override
  List<Fix> getFixes() => [_MakeUtilMethodsStatic()];
}

// Fix that replaces adds `static` keyword to a `Utils` method
class _MakeUtilMethodsStatic extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    // Callback fn that runs on every class declaration in a file
    context.registry.addClassDeclaration((node) {
      final element = node.declaredElement;
      if (element == null) return;

      // Create a `ChangeBuilder` instance to do file operations with an action
      final changeBuilder = reporter.createChangeBuilder(
        message: 'Make the method static',
        priority: 1,
      );
      // iterate over all methods of the class
      for (var method in element.methods) {
        // `return` if the current method is not where the lint
        // error has appeared
        final sourceRange = SourceRange(
          method.nameOffset,
          method.nameLength,
        );
        if (!analysisError.sourceRange.intersects(sourceRange)) continue;
        // Use the `changeBuilder` to make Dart file edits
        changeBuilder.addDartFileEdit((builder) {
          // Use the `builder` to insert `static` keyword before method name
          builder.addSimpleInsertion(
            method.nameOffset,
            'static ',
          );
        });
      }
    });
  }
}
