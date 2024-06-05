
// Unidad aritemica logica (ALU) de 2 operaciones, datos de 8 bits

/* ALU Arithmetic and Logic Operations
----------------------------------------------------------------------
|  op  |   ALU Operation
----------------------------------------------------------------------
| 000  |   ALU_Out = y + x; 
----------------------------------------------------------------------
| 001  |   ALU_Out = y - x;
----------------------------------------------------------------------*/



module alu(
  input [7:0] y_i, // 8-bit input x
  input [7:0] x_i,
  input [2:0] op_i,
  output reg [7:0] r_o,
  output reg fz_o,
  output reg fc_o
);

  always @(*) begin
    fc_o = 1'b0;

    case(op_i)
      3'b000:  {fc_o, r_o} = y_i + x_i;  // ADD
      3'b001:  {fc_o, r_o} = y_i - x_i;  // SUB
    endcase

    fz_o = (r_o == 8'b0) ? 1'b1 : 1'b0;
  end

endmodule
