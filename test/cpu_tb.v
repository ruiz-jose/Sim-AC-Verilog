`include "src/cpu.v"

module cpu_tb;

  reg clk = 1'b0;
  reg [4:0] addr = 5'b0;


  integer test_idx = 0;

  cpu UUT(.clk_i(clk), .addr_i(addr));

  always begin
    clk = ~clk; #5;
  end

  initial begin
    $dumpfile("bin/cpu.vcd");
    $dumpvars(0, cpu_tb);
    
    for (test_idx = 0; test_idx < 32; test_idx++) begin
       $display("Resultado %d %d %d", UUT.addr_i, UUT.curr_ins, UUT.bus_alu);
       $display("--");
      #25;
    end

    $finish;
    $display("Testbench completed");
  end

endmodule