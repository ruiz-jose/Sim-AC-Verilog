`include "src/cpu.v"

module cpu_tb;
  // Declaración de las señales
  reg clk;
  reg reset;
  wire [7:0] reg_acc_o;
  wire [1:0] reg_sw_o;
  wire [4:0] curr_pc_o, addr_o;
  wire [7:0] curr_ins_o;
  wire [7:0] bus_alu_o;
  wire [7:0] bus_ram_o;
  wire wr_o, wm_o ;

  // Instancia del módulo cpu
  cpu uut (
    .clk_i(clk),
    .reset_i(reset),
    .reg_acc_o(reg_acc_o), // Conecta la salida del registro acumulador
    .reg_sw_o(reg_sw_o),
    .curr_pc(curr_pc_o),
    .curr_ins(curr_ins_o),
    .addr_o(addr_o),
    .bus_ram_o(bus_ram_o),
    .wr_o(wr_o),
    .wm_o(wm_o),
    .bus_alu_o(bus_alu_o) 
  );

  // Generación de la señal de reloj
  always
    #5 clk = ~clk;

  // Inicialización
  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;

    // Volcar todas las señales internas de todos los módulos
    $dumpfile("bin/cpu.vcd");
    $dumpvars(0, cpu_tb);


    // Inicio de Señales
    $display("-- Inicia Simulación --");
    $display("-----------------------------------------------------------");
    $display("|       Test  PC  ROM  |Wr Ac| |Wm Addr RAM|  |R_alu C  Z||");
    $display("-----------------------------------------------------------");
  end

  // Variable de conteo
  integer test_idx = 0;

  // Impresión de los valores durante los primeros 4 ciclos de reloj
  always @(posedge clk) begin
    #10;
    if (test_idx < 5) begin
      $display("|%d  %h   %h   %h  %h    %h  %h   %h     %h   %b  %b |", test_idx, curr_pc_o, curr_ins_o, wr_o, reg_acc_o, wm_o, addr_o, bus_ram_o, bus_alu_o, reg_sw_o[1], reg_sw_o[0]);
      test_idx++;
     end
      if (test_idx == 5) begin
        $display("---------------------------------------------------------");

        $display("-- Testbench completed --");
        $finish;
      end
  end   

endmodule