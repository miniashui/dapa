include stack.mk

SUBDIRS = tower tower-config tower-aadl tower-hal tower-mini

default: $(SUBDIRS)

$(SUBDIRS):
	make -C $@ test

.PHONY: $(SUBDIRS)

TRAVIS_STACK ?= stack --no-terminal

travis-test:
	$(TRAVIS_STACK) setup
	$(TRAVIS_STACK) build --test --no-run-tests --haddock --no-haddock-deps --pedantic
	make $(SUBDIRS)
