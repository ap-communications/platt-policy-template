package rbac.backstage.catalog_test

import data.rbac.backstage.catalog
import rego.v1

test_has_annotation if {
	annotation := "annnotation value"
	value := "test value"
	annon := catalog.has_annotation(annotation, value)
	annon.resourceType == "catalog-entity"
	annon.rule == "HAS_ANNOTATION"
	annon.params.annotation == annotation
	annon.params.value == value
}

test_has_label if {
	label := "test label"
	lab := catalog.has_label(label)
	lab.resourceType == "catalog-entity"
	lab.rule == "HAS_LABEL"
	lab.params.label == label
}

test_has_metadata if {
	key := "test key"
	value := "test value"
	meta := catalog.has_metadata(key, value)
	meta.resourceType == "catalog-entity"
	meta.rule == "HAS_METADATA"
	meta.params.key == key
	meta.params.value == value
}

test_has_spec if {
	key := "test key"
	value := "test value"
	spec := catalog.has_spec(key, value)
	spec.resourceType == "catalog-entity"
	spec.rule == "HAS_SPEC"
	spec.params.key == key
	spec.params.value == value
}

test_is_entity_owner if {
	claims := ["test claim", "test claim 2"]
	owner := catalog.is_entity_owner(claims)
	owner.resourceType == "catalog-entity"
	owner.rule == "IS_ENTITY_OWNER"
	owner.params.claims == claims
}

test_is_entity_kind if {
	kinds := ["test kind", "test kind 2"]
	kind := catalog.is_entity_kind(kinds)
	kind.resourceType == "catalog-entity"
	kind.rule == "IS_ENTITY_KIND"
	kind.params.kinds == kinds
}
