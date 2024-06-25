`include "reg8.v"
`include "pc.v"
`include "rom.v"
`include "ctrlunit.v"
`include "alu.v"
`include "branch.v"
`include "ram.v"

module cpu(
  input clk_i,
  input reset,
  output [7:0] reg_acc_o,
  output [4:0] curr_pc, addr_o,
  output [7:0] curr_ins,
  output [7:0] bus_alu_o,
  output [7:0] bus_ram_o,
  output wr_o, wm_o 

);
  wire [7:0] bus_ac_mem, bus_alu, bus_mem, bus_aob;
  wire flag_z, flag_c, pc_load;
  wire ctrl_jmp, ctrl_mw, ctrl_alu;
  // registers
  reg8 reg_acc(.clk_i(clk_i), .rst_i(reset), .wen_i(ctrl_wr), .d_i(bus_alu), .q_o(bus_aob));
  pc reg_pc(.clk_i(clk_i), .rst_i(reset), .jmp_en_i(pc_load), .jmp_addr_i(curr_ins[4:0]), .addr_o(curr_pc));

  // top level modules
  rom rom(.addr_i(curr_pc), .data_o(curr_ins));
  ctrlunit ctrlunit(.op_i(curr_ins[7:5]), .jmp_o(ctrl_jmp), .wr_o(ctrl_wr), .wm_o(ctrl_wm), .alu_o(ctrl_alu));

  branch branch(.op_i(curr_ins[7:5]), .flag_z_i(flag_z), .flag_c_i(flag_c), .ctrl_jmp_i(ctrl_jmp), .branch_o(pc_load));
  ram ram(.clk_i(clk_i), .wen_i(ctrl_wm), .din_i(bus_ac_mem), .addr_i(curr_ins[4:0]), .dout_o(bus_mem));
  alu alu(.x_i(bus_aob), .y_i(bus_mem), .op_i(curr_ins[7:5]), .r_o(bus_alu), .fz_o(flag_z), .fc_o(flag_c));

  // assign bus values  
  assign bus_ac_mem = (ctrl_mw) ? bus_aob : bus_alu;
  assign reg_acc_o = bus_aob; 
  assign bus_alu_o = bus_alu; 
  assign bus_ram_o = bus_mem; 
  assign wr_o = ctrl_wr; 
  assign wm_o = ctrl_wm; 
  assign addr_o = curr_ins[4:0]; 
  

endmodule