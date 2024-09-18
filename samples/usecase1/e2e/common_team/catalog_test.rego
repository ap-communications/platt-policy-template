package e2e.common_team_test

import data.rbac.backstage.catalog
import data.rbac.backstage.global
import data.rbac.backstage.test_utils
import data.rbac_policy
import rego.v1

test_user_is_allow_with_catalog_read_permission if {
	identity := test_utils.user_identity("common_test_user", ["group:default/TeamA"])

	every permission in catalog.read_permissions {
		rbac_policy.decision == global.result_allow with input as test_utils.create_input(permission, identity)
	}
}

test_user_is_allow_with_catalog_create_permission if {
	identity := test_utils.user_identity("common_test_user", ["group:default/TeamA"])

	every permission in catalog.create_permissions {
		rbac_policy.decision == global.result_allow with input as test_utils.create_input(permission, identity)
	}
}

test_user_is_conditionals_with_catalog_delete_permission if {
	identity := test_utils.user_identity("common_test_user", ["group:default/TeamA"])

	every permission in catalog.delete_permissions {
		rbac_policy.decision.result == "CONDITIONAL" with input as test_utils.create_input(permission, identity)
	}
}