package rbac.backstage.catalog

import rego.v1

entity_create_permission := "catalog.entity.read"

entity_read_permission := "catalog.entity.read"

entity_delete_permission := "catalog.entity.delete"

entity_refresh_permission := "catalog.entity.refresh"

location_create_permission := "catalog.location.create"

location_read_permission := "catalog.location.read"

location_delete_permission := "catalog.location.delete"

entity_permissions := [
	entity_create_permission,
	entity_read_permission,
	entity_delete_permission,
	entity_refresh_permission,
]

locatoin_permissions := [
	location_create_permission,
	location_read_permission,
	location_delete_permission,
]

permissions := array.concat(
	entity_permissions,
	locatoin_permissions,
)
