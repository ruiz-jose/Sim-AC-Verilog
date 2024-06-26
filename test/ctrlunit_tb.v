`include "src/ctrlunit.v"

module ctrlunit_tb;

  reg [2:0] op = 3'b000;
  reg [1:0] flags = 2'b00;

  wire alux;
  wire aluy;
  wire aluop;
  wire wr; // write registro Acumulador
  wire wm; // write memoria RAM
  wire jmp; // PC load
  wire wf; // write registro de estado
  wire ldi;

  integer test_idx = 0;

  ctrlunit UUT(
    .op_i(op), .flags_i(flags),
    .alux_o(alux), .aluy_o(aluy), .aluop_o(aluop), .wr_o(wr), .wm_o(wm), .jmp_o(jmp), .wf_o(wf), .ldi_o(ldi)
  );

  initial begin
    $dumpfile("bin/ctrlunit.vcd");
    $dumpvars(0, ctrlunit_tb);


    // Inicio de Señales
    $display("-- Inicia Simulación --");
    $display("----------------------------------------------------");
    $display("|  Op Carry Zero | alux aluy aluop wr wm jmp wf ldi|");
    $display("----------------------------------------------------");

    op = 3'b000;  // SUB
    flags = 2'b00;
    #10;  // delay de 10 unidades de tiempo (tiempo de reloj)
    test_idx++; 
    $display("|   %d   %b    %b   |   %b    %b    %b   %b  %b   %b  %b   %b |", op, flags[1], flags[0], alux, aluy, aluop, wr, wm, jmp, wf, ldi);
   
    op = 3'b001;  // SUB
    #10; test_idx++;
    $display("|   %d   %b    %b   |   %b    %b    %b   %b  %b   %b  %b   %b |", op, flags[1], flags[0], alux, aluy, aluop, wr, wm, jmp, wf, ldi);
   
    op = 3'b010;  // LDA
    #10; test_idx++;
    $display("|   %d   %b    %b   |   %b    %b    %b   %b  %b   %b  %b   %b |", op, flags[1], flags[0], alux, aluy, aluop, wr, wm, jmp, wf, ldi);
   
    op = 3'b011;  // STA
    #10; test_idx++;
    $display("|   %d   %b    %b   |   %b    %b    %b   %b  %b   %b  %b   %b |", op, flags[1], flags[0], alux, aluy, aluop, wr, wm, jmp, wf, ldi);

    op = 3'b100;  // JMP
    #10; test_idx++;
    $display("|   %d   %b    %b   |   %b    %b    %b   %b  %b   %b  %b   %b |", op, flags[1], flags[0], alux, aluy, aluop, wr, wm, jmp, wf, ldi);
   
    op = 3'b101;  // JZ
    flags = 2'b01;
    #10; test_idx++; 
    $display("|   %d   %b    %b   |   %b    %b    %b   %b  %b   %b  %b   %b |", op, flags[1], flags[0], alux, aluy, aluop, wr, wm, jmp, wf, ldi);


    op = 3'b110;  // JC
    flags = 2'b10;
    #10; test_idx++;
    $display("|   %d   %b    %b   |   %b    %b    %b   %b  %b   %b  %b   %b |", op, flags[1], flags[0], alux, aluy, aluop, wr, wm, jmp, wf, ldi);

    op = 3'b111;  // LDI
    #10; test_idx++;
    $display("|   %d   %b    %b   |   %b    %b    %b   %b  %b   %b  %b   %b |", op, flags[1], flags[0], alux, aluy, aluop, wr, wm, jmp, wf, ldi);


   $display("----------------------------------------------------");
   $display("-- Testbench completed --");
   $finish;
  end

endmodule
