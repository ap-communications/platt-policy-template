package rbac.backstage.catalog_test

import data.rbac.backstage.catalog
import rego.v1

test_result_catalog_conditional if {
	conditions := ["test condition", "test condition 2"]
	catalog.result_catalog_conditional(conditions) == {
		"result": "CONDITIONAL",
		"pluginId": "catalog",
		"resourceType": "catalog-entity",
		"conditions": conditions,
	}
}
