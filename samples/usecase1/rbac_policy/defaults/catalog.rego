package rbac_policy.defaults

import data.rbac.backstage.catalog
import data.rbac.backstage.global
import rego.v1

decision := global.result_allow if {
	input.permission.name in catalog.read_permissions
} else := global.result_allow if {
	input.permission.name in catalog.create_permissions
} else := catalog.result_catalog_conditional(catalog.is_entity_owner(input.identity.claims)) if {
	input.permission.name in catalog.write_permissions
}
