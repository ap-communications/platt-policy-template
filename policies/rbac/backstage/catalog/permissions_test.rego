package rbac.backstage.catalog_test

import data.rbac.backstage.catalog
import rego.v1

test_permission_definitions_are_correct if {
	catalog.entity_refresh_permission in catalog.permissions
	catalog.location_delete_permission in catalog.permissions
}
