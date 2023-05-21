import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// Lint rule to make sure there's only one `Service` class per file
class OneServiceClassPerFile extends DartLintRule {
  OneServiceClassPerFile() : super(code: _code);

  // Lint rule metadata
  static const _code = LintCode(
    name: 'one_service_class_per_file',
    problemMessage: 'Only one Service class allowed per file',
  );

  // `run` is where you analyze a file and report lint errors
  // Invoked on a file automatically on every file edit
  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // check if the name of the file ends with `Service.dart`
    final fileName = resolver.source.shortName;
    if (!fileName.endsWith("Service.dart")) return;

    int classCount = 0;
    // A call back fn that runs on all class declarations in a file
    context.registry.addClassDeclaration((node) {
      final element = node.declaredElement;
      if (element == null) return;

      // increment the `classCount`
      classCount++;
      // if `classCount` is more than 1
      if (classCount > 1) {
        // report a lint error with the `code` and the respective class
        reporter.reportErrorForElement(code, element);
      }
    });
  }
}
