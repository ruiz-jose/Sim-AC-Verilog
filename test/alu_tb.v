`include "src/alu.v"

// Banco de pruebas para la ALU
// Este módulo genera varios casos de prueba para la ALU y verifica los resultados.
//
// Para ejecutar el banco de pruebas, usa el siguiente comando:
//   make target MOD=alu


module alu_tb;
  reg [7:0] x = 8'b00000000;  
  reg [7:0] y = 8'b00000000;
  reg [2:0] op = 3'b000;

  wire fz, fc;
  wire [7:0] r;

  integer test_idx = 0;

  alu UUT(
    .x_i(x), .y_i(y), .op_i(op), 
    .r_o(r), .fz_o(fz), .fc_o(fc)
  );

  initial begin
    $dumpfile("bin/alu.vcd");
    $dumpvars(0, alu_tb);

    // Inicio de Señales
    $display("-- Inicia Simulación --");
    $display("--------------------------------------");
    $display("--  x  Op  y  Resultado Zero Carry  --");
    $display("--------------------------------------");

    // ADD
    x = 8'b00000001;
    y = 8'b00000001;   
    op = 3'b000;
    #25; test_idx++; //delay
    $display("  %d  + %d = %d       %d     %d", x, y, r, fz, fc);
    $display("--------------------------------------");

    // SUB
    x = 7; 
    y = 3;    
    op = 1;   
    #25; test_idx++;
    $display("  %d  - %d = %d       %d     %d", x, y, r, fz, fc);
 

    // SUB y ZERO   
    x = 2;
    y = 2;
    op = 1;    
    #25; test_idx++;
    $display("  %d  - %d = %d       %d     %d", x, y, r, fz, fc);

    // SUB y CARRY   
    x = 3;
    y = 4;  
    op = 1;  
    #25; test_idx++;
    $display("  %d  - %d = %d       %d     %d", x, y, r, fz, fc);

    // ADD, CARRY y ZERO 
    x = 255;
    y = 1;     
    op = 0;   
    #25; test_idx++;
    $display("  %d  + %d = %d       %d     %d", x, y, r, fz, fc);
    $display("--------------------------------------");

    $display("-- Testbench completed --");
    $finish;
 
  end

endmodule
