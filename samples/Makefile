USECASES := usecase1
POLOCY_TOOLS = ../policies

.PHONY: fmt check test

all: fmt check lint test

fmt:
	@opa fmt . --write

check:
	@opa check ${USECASES} ${POLOCY_TOOLS}

lint:
	@regal lint ${USECASES} ${POLOCY_TOOLS}

test:
	@opa test -v ${USECASES} ${POLOCY_TOOLS}
