import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'assists/insert_spell_in_string_literal.dart';
import 'lint_rules/dont_say_his_name.dart';
import 'lint_rules/one_service_class_per_file.dart';
import 'lint_rules/util_methods_be_static.dart';

// Entrypoint of plugin
PluginBase createPlugin() => _MyLints();

// The class listing all the [LintRule]s and [Assist]s defined by our plugin
class _MyLints extends PluginBase {
  // Lint rules
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        DontSayHisName(),
        UtilMethodsBeStatic(),
        OneServiceClassPerFile(),
      ];

  // Assists
  @override
  List<Assist> getAssists() => [
        InsertSpellInStringLiteral(),
      ];
}
