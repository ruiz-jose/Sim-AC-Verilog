`include "src/rom.v"

module rom_tb;
  
  reg [4:0] addr = 5'b0;
  wire [7:0] data = 8'b0;

  integer test_idx = 0;

  rom UUT(.addr_i(addr), .data_o(data));

  initial begin
    $dumpfile("bin/rom.vcd");
    $dumpvars(0, rom_tb);

    for (test_idx = 0; test_idx < 4; test_idx++) begin
      #10;
      addr++;
    end
    
    $display("Testbench completed");
    $finish;

  end

endmodule
