package rbac_policy.defaults_test

import data.rbac.backstage.catalog
import data.rbac.backstage.global
import data.rbac.backstage.test_utils
import data.rbac_policy.defaults
import rego.v1

test_catalog_read_decision_allow if {
	every permission in catalog.read_permissions {
		identity := test_utils.user_identity("test_user", ["group:default/dev_team_1"])
		defaults.decision == global.result_allow with input as test_utils.create_input(permission, identity)
	}
}

test_catalog_create_decision_allow if {
	every permission in catalog.create_permissions {
		identity := test_utils.user_identity("test_user", ["group:default/dev_team_1"])
		defaults.decision == global.result_allow with input as test_utils.create_input(permission, identity)
	}
}

test_catalog_delete_decision_conditional if {
	every permission in catalog.delete_permissions {
		identity := test_utils.user_identity("test_user", ["group:default/dev_team_1"])
		expected_result := catalog.result_catalog_conditional(catalog.is_entity_owner(identity.claims))
		defaults.decision == expected_result with input as test_utils.create_input(permission, identity)
	}
}
