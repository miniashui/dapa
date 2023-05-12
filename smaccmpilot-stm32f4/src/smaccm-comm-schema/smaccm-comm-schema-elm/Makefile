ELM=elm-make
ELM_SRC=src

default: elm

.PHONY: elm
elm:
	$(ELM) $(ELM_SRC)/SMACCMPilot/Comm/Interface/*.elm --yes

.PHONY: clean
clean:
	rm -rf elm-stuff