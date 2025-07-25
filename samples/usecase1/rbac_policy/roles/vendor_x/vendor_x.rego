package rbac_policy.roles.vendor_x

import data.rbac.backstage.catalog
import data.rbac.backstage.global
import rego.v1

decision := catalog.result_catalog_conditional(catalog.is_entity_owner("group:default/TeamA")) if {
	_is_vender_x(input.identity.claims)
	input.permission.name in catalog.read_permissions
} else := global.result_deny if {
	_is_vender_x(input.identity.claims)
}

_is_vender_x(claims) := global.is_member_of("group:default/VendorX", claims)
