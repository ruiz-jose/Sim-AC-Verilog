/* Control Unit */

module ctrlunit(
  input [2:0] op_i,
  output reg jmp_o,
  output reg mr_o,
  output reg mw_o,
  output reg alu_o
);

  always @(*) begin
    jmp_o = 1'b0;
    mr_o  = 1'b0;
    mw_o  = 1'b0;
    alu_o = 1'b0;

    case (op_i)
      3'b000:  {alu_o, mw_o} = 2'b01;  // ADD
      3'b001:  {alu_o, mw_o} = 2'b11;  // SUB
      3'b010:  mr_o  = 1'b1;           // LDA
      3'b011:  mw_o  = 1'b1;           // STA
      3'b100:  jmp_o = 1'b1;           // JMP
      3'b101:  jmp_o = 1'b1;           // JZ
      3'b110:  jmp_o = 1'b1;           // JC   
    endcase
  end

endmodule
