SOURCES = src/prelude.smt2.md src/lemmas.k.md src/storage.k.md src/specs.md

specs: dapp
	klab build

dapp:
	git submodule sync --recursive
	git submodule update --init --recursive
	cd ds-token && dapp --use solc:0.5.12 build

.PHONY: clean
clean:
	cd ds-token && dapp clean
	rm -rf out/
