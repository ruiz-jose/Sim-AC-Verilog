`include "src/alu.v"


// Banco de pruebas para la ALU
// Este módulo genera varios casos de prueba para la ALU y verifica los resultados.
// Los casos de prueba incluyen varias combinaciones de operandos y operaciones.
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

    // ADD
    op = 3'b000;
    y = 8'b00000001;
    x = 8'b00000001;
    #25; test_idx++; //delay
    $display("Resultado %d ADD %d : %d", y, x, r);
    $display("--");

    // SUB
    op = 3'b001;
    y = 8'b00000101;
    x = 8'b00000010;    
    #25; test_idx++;
    $display("Resultado %d SUB %d : %d", y, x, r);
    $display("--");

    // ZERO
    op = 3'b001;
    y = 8'b00000011;
    x = 8'b00000011;    
    #25; test_idx++;
    $display("Resultado %d SUB %d : %d  zero: %d", y, x, r, fz);
    $display("--");

    // CARRY
    op = 3'b001;
    y = 8'b00000001;
    x = 8'b00000100;    
    #25; test_idx++;
<<<<<<< HEAD
    $display("Resultado %d SUB %d : %d  carry: %d", x,y,r, fc);
    $display("--");
=======
    $display("Resultado %d SUB %d : %d  carry: %d", y, x, r, fc);
    $display("--");

    // CARRY
    op = 3'b000;
    y = 8'b00000001;
    x = 8'b11111111;    
    #25; test_idx++;
    $display("Resultado %d SUB %d : %d  carry: %d", y, x, r, fc);

>>>>>>> ddf2267 (comentarios alu)
    $display("-- Testbench completed --");
    $finish;
 
  end

endmodule
