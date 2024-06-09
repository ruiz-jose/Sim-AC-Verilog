/* CPU - top level module */

`include "alu.v"
`include "branch.v"
`include "ctrlunit.v"
`include "pc.v"
`include "ram.v"
`include "reg8.v"
`include "rom.v"

module cpu(
  input clk_i,
  input [4:0] addr_i
);

  wire [4:0] curr_pc;
  wire [7:0] curr_ins;
  wire [7:0] bus_aib, bus_aob, bus_alu;
  wire [7:0] bus_mem;
  wire flag_z, flag_c, pc_load;
  wire ctrl_jmp, ctrl_mr, ctrl_mw, ctrl_alu;

	assign curr_ins =  8'b00000000;
  assign bus_aib =  8'b0;
  assign curr_pc = 5'b0;
initial begin
  $monitor($stime,",curr_pc=",curr_pc, ", curr_ins=", curr_ins, ",bus_aib=", bus_aib); 
end

/*
  // registers
  reg8 reg_ac(.clk_i(clk_i), .wen_i(1'b1), .d_i(bus_aib), .q_o(bus_aob));
*/
  pc reg_pc(.clk_i(clk_i), .rst_i(1'b0), .jmp_en_i(pc_load), 
    .jmp_addr_i(curr_ins[4:0]), .addr_o(curr_pc));
 
  // top level modules
  rom rom(.addr_i(curr_pc), .data_o(curr_ins));
/*
  ctrlunit ctrlunit(.op_i(curr_ins[7:5]), .jmp_o(ctrl_jmp), .mr_o(ctrl_mr), 
    .mw_o(ctrl_mw), .alu_o(ctrl_alu));

  branch branch(.op_i(curr_ins[7:5]), .flag_z_i(flag_z), .flag_c_i(flag_c), 
    .ctrl_jmp_i(ctrl_jmp), .branch_o(pc_load));

  ram ram(.clk_i(clk_i), .wen_i(ctrl_mw), 
    .din_i(bus_alu[7:0]), .addr_i(curr_ins[4:0]), .dout_o(bus_mem));

  alu alu(.x_i(bus_mem), .y_i(bus_aob), .op_i(curr_ins[7:5]), 
    .r_o(bus_alu), .fz_o(flag_z), .fc_o(flag_c));

  // assign bus values  
 // assign bus_aib =  (ctrl_alu) ? bus_alu :  8'b0;
*/

endmodule
