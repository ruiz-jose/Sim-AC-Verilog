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
//   a, b: operandos de 8 bits
//   op: señal de control de 3 bits. 000 = suma, 001 = resta
//
// Salidas:
//   r: resultado de la operación
//   zero: señal de cero. Se activa si el resultado es cero.
//   carry: señal de desbordamiento. Se activa si el resultado es demasiado grande para representarlo con 8 bits sin signo.

module alu(
  input [7:0] x_i, // 8-bit input x
  input [7:0] y_i,
  input [2:0] op_i,
  output reg [7:0] r_o,
  output reg [1:0] flags_o // flags_o[0] = fz, flags_o[1] = fc
);

  always @(*) begin
    case(op_i)
      3'b000:  {flags_o[1], r_o} = x_i + y_i;  // ADD
      3'b001:  {flags_o[1], r_o} = x_i - y_i;  // SUB
      3'b010, 3'b111: r_o = y_i;               // LDA, LDI
    endcase
    flags_o[0] = (r_o == 8'b0) ? 1'b1 : 1'b0; // fz

  end

endmodule
