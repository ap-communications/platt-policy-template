package rbac_policy.defaults

import data.rbac.backstage.global
import data.rbac.backstage.scaffolder
import rego.v1

decision := global.result_allow if {
	input.permission.name in scaffolder.permissions
}
