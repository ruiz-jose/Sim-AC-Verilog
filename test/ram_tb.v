`include "src/ram.v"

module ram_tb;
  
  reg clk = 1'b0;
  reg wen = 1'b0;
  reg [7:0] din = 8'b0;
  reg [4:0] addr = 5'b0;

  wire [7:0] dout;

  integer test_idx = 0;

  ram UUT(
    .clk_i(clk), .wen_i(wen), .din_i(din), .addr_i(addr), 
    .dout_o(dout)
  );

  always begin
    clk = ~clk; #5;
  end

  initial begin
    $dumpfile("bin/ram.vcd");
    $dumpvars(0, ram_tb);

  // Inicio de Señales
    $display("-- Inicia Simulación --");
    $display("--------------------------------------------");
    $display("|         Test    Addr   Din   Write   Dout|");
    $display("--------------------------------------------");
  
    #10; test_idx++;
    wen = 0;  // read
    din = 7;
    $display("|%d       %d    %d      %d   %d  |", test_idx, addr, din, wen, dout);


    addr++;  // 1
    #10; test_idx++;
    din = 7;
    $display("|%d       %d    %d      %d   %d  |", test_idx, addr, din, wen, dout);

    wen = 1; // write
    din = 7;
    #10; test_idx++;
    $display("|%d       %d    %d      %d   %d  |", test_idx, addr, din, wen, dout);

    addr++;  // 2
    wen = 0;  // read
    din = 8;
    #10; test_idx++;
    $display("|%d       %d    %d      %d   %d  |", test_idx, addr, din, wen, dout);

    wen = 1;  // write
    #10; test_idx++;
    $display("|%d       %d    %d      %d   %d  |", test_idx, addr, din, wen, dout);

    wen = 0; // read
    #10; test_idx++;
    $display("|%d       %d    %d      %d   %d  |", test_idx, addr, din, wen, dout);

    addr--;  // 1
    #10; test_idx++;
    $display("|%d       %d    %d      %d   %d  |", test_idx, addr, din, wen, dout);

    addr--; // 0
    #10; test_idx++;
    $display("|%d       %d    %d      %d   %d  |", test_idx, addr, din, wen, dout);
  
    $display("--------------------------------------------");

    $display("-- Testbench completed --");
    $finish;
  end

endmodule
