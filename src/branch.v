/* Logic for determining if a branch should occur */

module branch(
  input [2:0] op_i,
  input flag_z_i,
  input flag_c_i,
  input ctrl_jmp_i,
  output reg branch_o
);

  reg jmp, brz, brc;

  always @(*) begin
      
    jmp = (op_i[2] & ~op_i[1] & ~op_i[0]);             // JMP = 100
    brz = flag_z_i & (op_i[2] & ~op_i[1] & op_i[0]);   // JZ  = 101
    brc = flag_c_i & (op_i[2] & op_i[1] & ~op_i[0]);   // JC  = 110

    branch_o = (jmp | brz | brc) & ctrl_jmp_i;
  end

endmodule
