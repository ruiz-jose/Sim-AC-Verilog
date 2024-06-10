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

    #25; test_idx++;
   
    addr++;
    #25; test_idx++;

    wen = 1'b1;
    din = 8'b00000111;
    #25; test_idx++;

    wen = 1'b0;
    din = 8'b00000101;
    addr++;
    #25; test_idx++;

    wen = 1'b1;
    #25; test_idx++;

    wen = 1'b0;
    #25; test_idx++;


    addr--;
    #25; test_idx++;

    addr++;
    #25; test_idx++;

    $finish;
    $display("-- Testbench completed --");
  end

endmodule
