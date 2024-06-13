`include "src/cpu.v"
module cpu_tb;
  // Declaración de las señales
  reg clk;
  reg reset;
  wire [7:0] bus_aob;
  wire [4:0] curr_pc;
  wire [7:0] curr_ins;

  // Instancia del módulo cpu
  cpu uut (
    .clk_i(clk),
    .reset(reset),
    .reg_acc_out(reg_acc_out), // Conecta la salida del registro acumulador
    .curr_pc(curr_pc),
    .curr_ins(curr_ins)
  );

  // Generación de la señal de reloj
  always
    #5 clk = ~clk;

  // Inicialización
  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
  end

  // Variable de conteo
  integer count = 0;

  // Impresión de los valores durante los primeros 4 ciclos de reloj
  always @(posedge clk) begin
    if (count < 5) begin
      $display("curr_pc: %h, curr_ins: %h,  reg_acc_out: %h", curr_pc, curr_ins,  reg_acc_out);
      count = count + 1;
     end
      if (count == 5) begin
        $finish;
      end
  end   

endmodule