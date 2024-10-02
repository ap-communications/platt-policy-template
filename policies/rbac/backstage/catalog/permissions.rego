package rbac.backstage.catalog

import rego.v1

entity_create_permission := "catalog.entity.create"

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

location_permissions := [
	location_create_permission,
	location_read_permission,
	location_delete_permission,
]

permissions := array.concat(
	entity_permissions,
	location_permissions,
)

read_permissions := [
	entity_read_permission,
	location_read_permission,
	entity_refresh_permission,
]

write_permissions := [
	entity_create_permission,
	entity_delete_permission,
	location_create_permission,
	location_delete_permission,
]

create_permissions := [
	entity_create_permission,
	location_create_permission,
]

delete_permissions := [
	entity_delete_permission,
	location_delete_permission,
]
