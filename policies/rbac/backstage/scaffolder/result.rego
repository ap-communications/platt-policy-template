package rbac.backstage.scaffolder

import data.rbac.backstage.global
import rego.v1

result_template_conditional(conditions) := global.conditional("scaffolder", "scaffolder-template", conditions)

result_action_conditional(conditions) := global.conditional("scaffolder", "scaffolder-action", conditions)

result_task_conditional(conditions) := global.conditional("scaffolder", "scaffolder-task", conditions)
