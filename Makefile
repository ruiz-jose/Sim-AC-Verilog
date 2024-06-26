COMPILE = iverilog
SIMULATE = vvp
VIEW = gtkwave
OUT = bin
SRC = src
EXAMPLE = examples
TEST = test

MOD =
EJ ?= ej_1

.PHONY: clean setup target view

clean:
	-rm -f $(OUT)/*

setup:
    $(eval export ROM_MEM=$(EXAMPLE)/rom_$(EJ).mem)
    $(eval export DATA_MEM=$(EXAMPLE)/data_$(EJ).mem)

target: clean setup
	@mkdir -p $(OUT)
	@echo "Compilando y simulando $(MOD) con el ejemplo $(EJ)"
	$(COMPILE) "$(TEST)/$(MOD)_tb.v" src -o "$(OUT)/$(MOD).vvp"  -I $(SRC) -DROM_MEM=\"$(EXAMPLE)/rom_$(EJ).mem\" -DDATA_MEM=\"$(EXAMPLE)/data_$(EJ).mem\"
	$(SIMULATE) -n "$(OUT)/$(MOD).vvp"

#view:
#    @echo "Abriendo $(OUT)/$(MOD).vcd con GTKWave"
#    $(VIEW) "$(OUT)/$(MOD).vcd"