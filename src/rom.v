/* Program ROM 32x8 - 5-bit addresses, 8-bit instruction */

module rom(
  input [4:0] addr_i,
  output reg [7:0] data_o
);

  reg [7:0] memory [0:31];

  initial begin
    $display("Loading ROM...");
    $readmemh("src/rom_ej_3.mem", memory);
  end

  always @(*) begin
    data_o <= memory[addr_i];
  end

endmodule
