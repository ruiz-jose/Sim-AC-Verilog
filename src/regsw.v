/* 2-bit register Status Word*/

module regsw(
  input clk_i,
  input wen_i,
  input rst_i,
  input [1:0] d_i,
  output reg [1:0] q_o
);

  always @(posedge clk_i or posedge rst_i) begin
    if (wen_i) begin
      q_o <= d_i;
    end
    if (rst_i) begin
      q_o <= 2'b0;
    end
  end

endmodule
