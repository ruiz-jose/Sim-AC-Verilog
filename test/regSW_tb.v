`include "src/regSW.v"

module regSW_tb;

  reg clk = 1'b0;
  reg rst = 1'b0;
  reg wen = 1'b0;
  reg [1:0] d = 2'b0;

  wire [1:0] q;

  integer test_idx = 0;

  regSW UUT(.clk_i(clk), .rst_i(rst), .wen_i(wen), .d_i(d), .q_o(q));
  
  always begin
    clk = ~clk; #5;
  end

  initial begin
    $dumpfile("bin/regSW.vcd");
    $dumpvars(0, regSW_tb);

    // Inicio de Señales
    $display("-- Inicia Simulación --");
    $display("---------------------------------------------");
    $display("|         Test   rst    Write   Registro SW |");
    $display("---------------------------------------------");
    
     // reset
    rst = 1'b1;
    #10; test_idx++;
    $display("|%d        %d     %d       %b     |", test_idx, rst, wen, q);

    // d should be saved to q
    wen = 1'b1;
    rst = 1'b0;
    d = 2'b11; 
    #10; test_idx++;
    $display("|%d        %d     %d       %b     |", test_idx, rst, wen, q);

    // d should not be saved to q
    wen = 1'b0;
    d = 2'b01;  
    #10; test_idx++;
    $display("|%d        %d     %d       %b     |", test_idx, rst, wen, q);

    // d should not be saved to q
    wen = 1'b1;
    #10; test_idx++;
    $display("|%d        %d     %d       %b     |", test_idx, rst, wen, q);

    $display("----------------------------------------");

    $display("-- Testbench completed --");
    $finish;
  end

endmodule
