# Sim-AC-Verilog

Una CPU basada en acumulador de 8 bits diseñada para hacer lo mínimo y nada más.


## Verilog Testbenches

example: `make target MOD=alu`

CPU with [test ROM](test/test_rom.txt): `make target MOD=cpu EJ=ej_1`

This makefile compiles the target module with `iverilog`, 
simulates it with `vvp`, and opens the waveform in `gtkwave`.