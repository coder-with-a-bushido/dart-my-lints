import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class OneUtilClassPerFile extends DartLintRule {
  OneUtilClassPerFile() : super(code: _code);

  static const _code = LintCode(
    name: 'one_util_class_per_file',
    problemMessage: 'Only one Util class allowed per file',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    final fileName = resolver.source.shortName;
    if (!fileName.endsWith("Utils.dart")) return;

    int classCount = 0;
    context.registry.addClassDeclaration((node) {
      final element = node.declaredElement;
      if (element == null) return;

      classCount++;
      if (classCount > 1) {
        reporter.reportErrorForElement(code, element);
      }
    });
  }
}
