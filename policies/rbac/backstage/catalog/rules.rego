package rbac.backstage.catalog

import rego.v1

_make_rule(rule, params) := {
	"resourceType": "catalog-entity",
	"rule": rule,
	"params": params,
}

# annotation: Name of the annotation to match on
# value: Value of the annotation to match on
has_annotation(annotation, value) := _make_rule(
	"HAS_ANNOTATION",
	{
		"annotation": annotation,
		"value": value,
	},
)

# label: Name of the label to match on
has_label(label) := _make_rule(
	"HAS_LABEL",
	{"label": label},
)

# key: key name within the entities 'metadata' to match on
# value: value of the given property to match on
has_metadata(key, value) := _make_rule(
	"HAS_METADATA",
	{
		"key": key,
		"value": value,
	},
)

# key: key name within the entities 'spec' to match on
# value: value of the given property to match on
has_spec(key, value) := _make_rule(
	"HAS_SPEC",
	{
		"key": key,
		"value": value,
	},
)

# claims: List of claims to match at least one on within 'owndedBy' field
is_entity_owner(claims) := _make_rule(
	"IS_ENTITY_OWNER",
	{"claims": claims},
)

# kinds: List of kinds to match at least one of
is_entity_kind(kinds) := _make_rule(
	"IS_ENTITY_KIND",
	{"kinds": kinds},
)
