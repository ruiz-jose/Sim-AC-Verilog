/* Control Unit */

module ctrlunit(
  input [2:0] op_i,
  input [1:0] flags_i,
  output reg alux_o,
  output reg aluy_o,
  output reg aluop_o,
  output reg wr_o, // write registro Acumulador
  output reg wm_o, // write memoria RAM
  output reg jmp_o, // PC load
  output reg wf_o, // write registro de estado
  output reg ldi_o
);

  always @(*) begin
    alux_o = 1'b0;
    aluy_o = 1'b0;
    aluop_o = 1'b0; 
    wr_o  = 1'b0;
    wm_o  = 1'b0;
    jmp_o = 1'b0;
    wf_o  = 1'b0;
    ldi_o = 1'b0;

    case (op_i)
      3'b000:  {aluop_o, wr_o, wf_o} = 3'b011;    // ADD
      3'b001:  {aluop_o, wr_o, wf_o} = 3'b111;    // SUB
      3'b010:  {alux_o, wr_o}  = 2'b11;         // LDA
      3'b011:  {aluy_o, wm_o}  = 2'b11;                    // STA
      3'b100:  jmp_o = 1'b1;                    // JMP
      3'b101:  jmp_o = flags_i[0];              // JZ
      3'b110:  jmp_o = flags_i[1];              // JC   
      3'b111:  {alux_o, wr_o, ldi_o} = 3'b111;  // LDI   
    endcase
  end

endmodule
