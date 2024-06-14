/* RAM 32x8 - 5-bit addressing, 8-bit word */

module ram(
  input clk_i,
  input wen_i,
  input [7:0] din_i,
  input [4:0] addr_i,
  output [7:0] dout_o
);

  reg [7:0] ram [0:31];
  integer i;
  
  // clear RAM on start
  initial begin
    $display("Loading RAM...");
    //-- Los valores deben estan dados en hexadecimal
    $readmemh("src/data.mem",ram);
  end

  always @(posedge clk_i) begin
    if (wen_i) begin
      ram [addr_i] = din_i;
    end
  end

  assign dout_o = ram [addr_i] ;

endmodule
