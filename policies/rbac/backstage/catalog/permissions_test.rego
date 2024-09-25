package rbac.backstage.catalog_test

import data.rbac.backstage.catalog
import rego.v1

test_permission_definitions_are_correct if {
	catalog.entity_refresh_permission in catalog.permissions
	catalog.location_delete_permission in catalog.permissions
	count(catalog.permissions) == 7
}

test_read_permission_definitions_are_correct if {
	catalog.entity_read_permission in catalog.read_permissions
	catalog.location_read_permission in catalog.read_permissions
	catalog.entity_refresh_permission in catalog.read_permissions
	count(catalog.read_permissions) == 3
}

test_write_permission_definitions_are_correct if {
	catalog.entity_create_permission in catalog.write_permissions
	catalog.entity_delete_permission in catalog.write_permissions
	catalog.location_create_permission in catalog.write_permissions
	catalog.location_delete_permission in catalog.write_permissions
	count(catalog.write_permissions) == 4
}

test_create_permission_definitions_are_correct if {
	catalog.entity_create_permission in catalog.create_permissions
	catalog.location_create_permission in catalog.create_permissions
	count(catalog.create_permissions) == 2
}

test_delete_permission_definitions_are_correct if {
	catalog.entity_delete_permission in catalog.delete_permissions
	catalog.location_delete_permission in catalog.delete_permissions
	count(catalog.delete_permissions) == 2
}
