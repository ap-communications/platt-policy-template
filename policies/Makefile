.PHONY: check check lint test testRbac

checkAll:
	make fmt
	make check
	make lint
	make test

check:
	@opa check .

fmt:
	@opa fmt . --write

lint: check
	@regal lint .

test: testRbac

testRbac:
	@opa test -v rbac
