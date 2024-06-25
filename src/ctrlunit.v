/* Control Unit */

module ctrlunit(
  input [2:0] op_i,
  output reg jmp_o,
  output reg wr_o, // write registro Acumulador
  output reg wm_o, // write memoria RAM
  output reg wf_o, // write registro de estado
  output reg alu_o,
  output reg alux_o,
  output reg ldi_o
);

  always @(*) begin
    jmp_o = 1'b0;
    wr_o  = 1'b0;
    wm_o  = 1'b0;
    wf_o  = 1'b0;
    alu_o = 1'b0;   
    alux_o = 1'b0;
    ldi_o = 1'b0;

    case (op_i)
      3'b000:  {alu_o, wr_o, wf_o} = 3'b011;    // ADD
      3'b001:  {alu_o, wr_o, wf_o} = 3'b111;    // SUB
      3'b010:  {alux_o, wr_o}  = 2'b11;         // LDA
      3'b011:  wm_o  = 1'b1;                    // STA
      3'b100:  jmp_o = 1'b1;                    // JMP
      3'b101:  jmp_o = 1'b1;                    // JZ
      3'b110:  jmp_o = 1'b1;                    // JC   
      3'b111:  {alux_o, wr_o, ldi_o} = 3'b111;  // LDI   
    endcase
  end

endmodule
