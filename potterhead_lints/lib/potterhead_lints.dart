import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'assists/suggest_spells_for_string.dart';
import 'lint_rules/dont_say_his_name.dart';
import 'lint_rules/one_util_class_per_file.dart';
import 'lint_rules/util_methods_be_static.dart';

// Entrypoint of plugin
PluginBase createPlugin() => _HarryPotterLint();

// The class listing all the [LintRule]s and [Assist]s defined by our plugin
class _HarryPotterLint extends PluginBase {
  // Lint rules
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        DontSayHisName(),
        UtilMethodsBeStatic(),
        OneUtilClassPerFile(),
      ];

  // Assists
  @override
  List<Assist> getAssists() => [
        AddSpellsForString(),
      ];
}
