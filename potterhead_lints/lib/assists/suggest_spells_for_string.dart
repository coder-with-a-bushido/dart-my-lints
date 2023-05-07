import 'dart:math';

import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// Assist to suggest spells to replace in string literals
class AddSpellsForString extends DartAssist {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    final rand = Random();
    // A list of spells
    final spells = [
      "Accio",
      "Alohomora",
      "Lumos",
      "Wingardium Leviosa",
      "Expecto Patronum"
    ];

    context.registry.addSimpleStringLiteral((node) {
      // `return` if the visited node is not under the cursor
      if (!target.intersects(node.sourceRange)) return;

      // Create `ChangeBuilder` instance to do file operations with an action
      final changeBuilder = reporter.createChangeBuilder(
        priority: 1,
        message: 'Add a random spell to the string',
      );
      // Use the `changeBuilder` to make Dart file edits
      changeBuilder.addDartFileEdit((builder) {
        // Use the `builder` to insert a string at the beginning of string literal
        builder.addSimpleInsertion(
          node.offset + 1,
          // A random value from the `spells` to insert
          '${spells.elementAt(rand.nextInt(spells.length - 1))}! ',
        );
      });
    });
  }
}
