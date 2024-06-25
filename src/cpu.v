`include "reg8.v"
`include "regSW.v"
`include "pc.v"
`include "rom.v"
`include "ctrlunit.v"
`include "alu.v"
`include "branch.v"
`include "ram.v"

module cpu(
  input clk_i,
  input reset_i,
  output [7:0] reg_acc_o,
  output [1:0] reg_SW_o,
  output [4:0] curr_pc, addr_o,
  output [7:0] curr_ins,
  output [7:0] bus_alu_o,
  output [7:0] bus_ram_o,
  output wr_o, wm_o

);
  wire [7:0] bus_alux, bus_aluy, bus_alur, bus_mem, bus_ac;
  wire pc_load;
  wire ctrl_alux, ctrl_aluop, ctrl_wr, ctrl_wm, ctrl_jmp, ctrl_wf, ctrl_ldi;
  wire [1:0] bus_flags, bus_sw;

  // registers
  reg8 reg_acc(.clk_i(clk_i), .rst_i(reset_i), .wen_i(ctrl_wr), .d_i(bus_alur), .q_o(bus_ac));
  pc reg_pc(.clk_i(clk_i), .rst_i(reset_i), .jmp_en_i(pc_load), .jmp_addr_i(curr_ins[4:0]), .addr_o(curr_pc));
  regSW reg_SW(.clk_i(clk_i), .rst_i(reset_i), .wen_i(ctrl_wf), .d_i(bus_flags), .q_o(bus_sw));

  // top level modules
  rom rom(.addr_i(curr_pc), .data_o(curr_ins));
  ctrlunit ctrlunit(.op_i(curr_ins[7:5]), .jmp_o(ctrl_jmp), .wr_o(ctrl_wr), .wm_o(ctrl_wm),.wf_o(ctrl_wf), .alu_o(ctrl_aluop), .alux_o(ctrl_alux), .ldi_o(ctrl_ldi));

  branch branch(.op_i(curr_ins[7:5]), .flags_i(bus_sw), .ctrl_jmp_i(ctrl_jmp), .branch_o(pc_load));
  ram ram(.clk_i(clk_i), .wen_i(ctrl_wm), .din_i(bus_ac), .addr_i(curr_ins[4:0]), .dout_o(bus_mem));
  alu alu(.x_i(bus_alux), .y_i( bus_aluy), .op_i(curr_ins[7:5]), .r_o(bus_alur), .flags_o(bus_flags));


  // assign bus values  
  assign bus_alux = (ctrl_alux) ? 8'b0 : bus_ac;
  assign bus_aluy = (ctrl_ldi) ? 8'b0 : bus_mem;

  // assign outputs
  assign reg_acc_o = bus_ac; 
  assign bus_alu_o = bus_alu; 
  assign addr_o = curr_ins[4:0]; 
  assign bus_ram_o = bus_mem; 
  assign wr_o = ctrl_wr; 
  assign wm_o = ctrl_wm;
  assign reg_SW_o = bus_sw;   
  

endmodule