package rbac.backstage.scaffolder

import data.rbac.backstage.global
import rego.v1

result_template_conditionional(conditions) := global.conditional("scaffolder", "scaffolder-template", conditions)

result_action_conditionional(conditions) := global.conditional("scaffolder", "scaffolder-action", conditions)
