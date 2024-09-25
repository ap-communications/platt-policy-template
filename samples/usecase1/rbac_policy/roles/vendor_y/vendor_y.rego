package rbac_policy.roles.vendor_y

import data.rbac.backstage.catalog
import data.rbac.backstage.global
import data.rbac.backstage.scaffolder
import rego.v1

decision := catalog.result_catalog_conditionional(catalog.is_entity_owner("grouop:default/TeamB")) if {
	_is_vender_y(input.identity.claims)
	input.permission.name in catalog.read_permissions
} else := global.result_allow if {
	_is_vender_y(input.identity.claims)
	input.permission.name in catalog.create_permissions
} else := global.result_allow if {
	_is_vender_y(input.identity.claims)
	input.permission.name in scaffolder.permissions
} else := global.result_deny if {
	_is_vender_y(input.identity.claims)
}

_is_vender_y(claims) := global.is_member_of("group:default/VendorY", claims)
