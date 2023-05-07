import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class UtilMethodsBeStatic extends DartLintRule {
  UtilMethodsBeStatic() : super(code: _code);

  static const _code = LintCode(
    name: 'static_utils_method',
    problemMessage: 'Methods in Util classes should be static',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration(
      (node) {
        final element = node.declaredElement;
        if (element == null || !element.name.endsWith("Utils")) {
          return;
        }
        for (var method in element.methods) {
          if (method.isStatic) {
            continue;
          }
          reporter.reportErrorForElement(code, method);
        }
      },
    );
  }

  @override
  List<Fix> getFixes() => [_MakeUtilMethodsStatic()];
}

class _MakeUtilMethodsStatic extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addClassDeclaration((node) {
      final element = node.declaredElement;
      if (element == null) return;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Make the method static',
        priority: 1,
      );

      for (var method in element.methods) {
        final sourceRange = SourceRange(method.nameOffset, method.nameLength);
        if (!analysisError.sourceRange.intersects(sourceRange)) continue;

        changeBuilder.addDartFileEdit((builder) {
          builder.addSimpleInsertion(method.nameOffset, 'static ');
        });
      }
    });
  }
}
