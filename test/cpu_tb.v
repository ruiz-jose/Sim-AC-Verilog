`include "src/cpu.v"

module cpu_tb;
  // Declaración de las señales
  reg clk;
  reg reset;
  wire [7:0] reg_acc_out;
  wire [4:0] curr_pc;
  wire [7:0] curr_ins;
  wire [7:0] bus_alu_out;
  wire [7:0] bus_ram_out;
  wire wr_o, wm_o;

  // Instancia del módulo cpu
  cpu uut (
    .clk_i(clk),
    .reset(reset),
    .reg_acc_out(reg_acc_out), // Conecta la salida del registro acumulador
    .curr_pc(curr_pc),
    .curr_ins(curr_ins),
    .bus_alu_out(bus_alu_out),
    .bus_ram_out(bus_ram_out),
    .wr_o(wr_o),
    .wm_o(wm_o)
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
    $display("-----------------------------------------------");
    $display("|       Test  PC  ROM  |Wr Ac| R_alu  |Wm RAM||");
    $display("-----------------------------------------------");
  end

  // Variable de conteo
  integer test_idx = 0;

  // Impresión de los valores durante los primeros 4 ciclos de reloj
  always @(posedge clk) begin
    #10; // Agrega un pequeño retraso
    if (test_idx < 5) begin
      $display("|%d  %h   %h   %h  %h    %h    %h  %h  |", test_idx, curr_pc, curr_ins, wr_o, reg_acc_out, bus_alu_out, wm_o, bus_ram_out);
      test_idx++;
     end
      if (test_idx == 5) begin
        $display("-----------------------------------------------");

        $display("-- Testbench completed --");
        $finish;
      end
  end   

endmodule