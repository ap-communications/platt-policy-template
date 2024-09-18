package rbac_policy.roles.administrators

import data.rbac.backstage.global
import rego.v1

_administrator := "group:default/administrators" # Put your administrator group name

decision := global.result_allow if {
	global.is_member_of(_administrator, input.identity.claims)
}
