package rbac_policy.defaults

import data.rbac.backstage.global
import data.rbac.backstage.kubernetes
import rego.v1

decision := global.result_allow if {
	input.permission.name == kubernetes.resources_read_permission
}
