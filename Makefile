COMPILE = iverilog
SIMULATE = vvp
VIEW = gtkwave
OUT = bin
SRC = src
TEST = test

MOD =
EJ ?= ej_1

.PHONY: clean setup target view

clean:
	-rm -f $(OUT)/*

setup:
    $(eval export ROM_MEM=$(SRC)/rom_$(EJ).mem)
    $(eval export DATA_MEM=$(SRC)/data_$(EJ).mem)

target: clean setup
	@mkdir -p $(OUT)
	@echo "Compilando y simulando $(MOD) con el ejemplo $(EJ)"
	$(COMPILE) "$(TEST)/$(MOD)_tb.v" src -o "$(OUT)/$(MOD).vvp"  -I $(SRC) -DROM_MEM=\"$(SRC)/rom_$(EJ).mem\" -DDATA_MEM=\"$(SRC)/data_$(EJ).mem\"
	$(SIMULATE) -n "$(OUT)/$(MOD).vvp"

#view:
#    @echo "Abriendo $(OUT)/$(MOD).vcd con GTKWave"
#    $(VIEW) "$(OUT)/$(MOD).vcd"