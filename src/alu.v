
// ALU (Unidad Aritmética Lógica)
// Esta ALU es capaz de realizar operaciones de suma y resta.
// Las operaciones se controlan mediante la señal de control `op`.
//        ----------------------------------
//        |  op  |   ALU Operation
//        ----------------------------------
//        | 000  |   ALU_Out = y + x; 
//        ----------------------------------
//        | 001  |   ALU_Out = y - x;
//        ----------------------------------
//
// Entradas:
//   a, b: operandos de 32 bits
//   op: señal de control de 1 bit. 0 = suma, 1 = resta
//
// Salidas:
//   y: resultado de la operación
//   overflow: señal de desbordamiento. Se activa si el resultado es demasiado grande para representarlo con 32 bits.


module alu(
  input [7:0] y_i, // 8-bit input y
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
