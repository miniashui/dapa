# This makefile is autogenerated. DO NOT EDIT.

# Make sure 'all' is the first target by putting it before any includes

all: generate
	# This sub-make is here to deal with bl_image.bin depending on
	# files that have to be generated first. This requires us
	# to do the build in two phases.
	make bl_image.bin image.px4


-include ramses.mk

# We assume ECHRONOS_LOCATION and PRJ are set in PRJ_CMD.mk \
ECHRONOS_LOCATION should be the path to the echronos install where\
the setenv script and packages can be found. For example, the top of\
your echronos repository. PRJ should point to the prj tool.

ECHRONOS_LOCATION ?= 

PRJ ?= $(ECHRONOS_LOCATION)/prj/app/prj.py

.PHONY: generate clean


generate: .tag.echronos .tag.ramses
	-mv user_code/*.[cs] gen/
	-rmdir user_code


.tag.echronos: .tag.ramses
	pushd $(ECHRONOS_LOCATION) && source setenv && popd &&  \
  $(ECHRONOS_LOCATION)/x.py build packages            &&  \
  $(PRJ) --output echronos_gen                            \
         --search-path $(ECHRONOS_LOCATION)/packages      \
         --no-project                                     \
         gen                                              \
         sys_impl.prx
	touch .tag.echronos


clean: echronos-clean tower-clean
	rm -f .tag.echronos


include echronos.mk

