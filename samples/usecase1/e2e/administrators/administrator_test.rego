package e2e.administrators_test

import data.rbac.backstage.catalog
import data.rbac.backstage.global
import data.rbac.backstage.scaffolder
import data.rbac.backstage.test_utils
import data.rbac_policy
import rego.v1

test_user_is_administrator_with_unknown_permission if {
	identity := test_utils.user_identity("admin_test_user", ["group:default/administrators"])

	rbac_policy.decision == global.result_allow with input as test_utils.create_input("test_permission", identity)
}

test_user_is_administrator_with_catalog_permission if {
	identity := test_utils.user_identity("admin_test_user", ["group:default/administrators"])

	every permission in catalog.permissions {
		rbac_policy.decision == global.result_allow with input as test_utils.create_input(permission, identity)
	}
}

test_user_is_administrator_with_scaffolder_permission if {
	identity := test_utils.user_identity("admin_test_user", ["group:default/administrators"])

	every permission in scaffolder.permissions {
		rbac_policy.decision == global.result_allow with input as test_utils.create_input(permission, identity)
	}
}
