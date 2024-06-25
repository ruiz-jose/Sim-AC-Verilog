`include "src/alu.v"

// Banco de pruebas para la ALU de 8 bits (Unidad Aritmética Lógica)
// Este módulo genera varios casos de prueba para la ALU y verifica los resultados.
//
// Para ejecutar el banco de pruebas, usa el siguiente comando:
// make target MOD=alu

module alu_tb;
  reg [7:0] x = 8'b00000000;  
  reg [7:0] y = 8'b00000000;
  reg [2:0] op = 3'b000;

  wire [1:0] flags;
  wire [7:0] r;

  integer test_idx = 0;

  alu UUT(
    .x_i(x), .y_i(y), .op_i(op), 
    .r_o(r), .flags_o(flags)
  );

  initial begin
    $dumpfile("bin/alu.vcd");
    $dumpvars(0, alu_tb);

    // Inicio de Señales
    $display("-- Inicia Simulación --");
    $display("--------------------------------------");
    $display("|    x  Op  y  Resultado Carry Zero  |");
    $display("--------------------------------------");

    // ADD
    x = 8'b00000001;
    y = 8'b00000001;   
    op = 3'b000;
    #10;  // delay de 10 unidades de tiempo (tiempo de reloj)
    test_idx++;
    $display("|  %d  + %d = %d        %b    %b    |", x, y, r, flags[1], flags[0]);


    // SUB
    x = 7; 
    y = 3;    
    op = 1;   
    #10; test_idx++;
    $display("|  %d  - %d = %d        %b    %b    |", x, y, r, flags[1], flags[0]);
 

    // SUB y ZERO   
    x = 2;
    y = 2;
    op = 1;    
    #10; test_idx++;
    $display("|  %d  - %d = %d        %b    %b    |", x, y, r, flags[1], flags[0]);

    // SUB y CARRY   
    x = 3;
    y = 4;  
    op = 1;  
    #10; test_idx++;
    $display("|  %d  - %d = %d        %b    %b    |", x, y, r, flags[1], flags[0]);

    // ADD, CARRY y ZERO 
    x = 255;
    y = 1;     
    op = 0;   
    #10; test_idx++;
    $display("|  %d  + %d = %d        %b    %b    |", x, y, r, flags[1], flags[0]);
    $display("--------------------------------------");

    $display("-- Testbench completed --");
    $finish;
 
  end

endmodule
