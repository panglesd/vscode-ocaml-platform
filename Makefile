OCAML_SRCFILES = $(shell git ls-files "*.ml" "*.mli")
REASON_SRCFILES = $(shell git ls-files "*.re" "*.rei")

build:
	dune build @vscode
.PHONY: build

watch:
	dune build @vscode -w
.PHONY: watch

clean:
	dune clean
.PHONY: clean

test:
	yarn test
.PHONY: test

fmt:
	ocamlformat --inplace --enable-outside-detected-project $(OCAML_SRCFILES)
	refmt --in-place $(REASON_SRCFILES)
	yarn fmt
.PHONY: fmt

# builds and packages the extension for installment
pkg: build
	vsce package --out ./test_extension.vsix --yarn
.PHONY: pkg

# builds, packages, and installs the extension to your VS Code
install: pkg
	code --force --install-extension test_extension.vsix
