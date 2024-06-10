`include "src/pc.v"

module pc_tb;

  reg clk = 1'b0;
  reg rst = 1'b0;
  reg jmp_en = 1'b0;
  reg [4:0] jmp_addr = 5'b0;

  wire [4:0] curr_addr;

  integer test_idx = 0;

  pc UUT(
    .clk_i(clk), .rst_i(rst), .jmp_en_i(jmp_en), .jmp_addr_i(jmp_addr),
    .addr_o(curr_addr)
  );

  always begin
    clk = ~clk; #5;
  end

  initial begin
    $dumpfile("bin/pc.vcd");
    $dumpvars(0, pc_tb);

    // Inicio de Señales
    $display("-- Inicia Simulación --");

    // reset
    rst = 1'b1;
    #25; test_idx++;
    $display("%d. Registro PC= %d ",test_idx, curr_addr);

    // inc
    rst = 1'b0;
    #25; test_idx++;
    $display("%d. Registro PC= %d ",test_idx, curr_addr);
    
    // inc
    #25; test_idx++;
    $display("%d. Registro PC= %d ",test_idx, curr_addr);

    // inc
    rst = 1'b0;
    $display("%d. Registro PC= %d ",test_idx, curr_addr);

    // jump
    jmp_en = 1'b1;
    jmp_addr = 5'b11001;  //19h
    #25; test_idx++;  // addr + 1
    $display("%d. Registro PC= %d ",test_idx, curr_addr);

    // reset
    rst = 1'b1;
    #25; test_idx++;
    $display("%d. Registro PC= %d ",test_idx, curr_addr);

    // inc
    rst = 1'b0;
    #25; test_idx++;
    $display("%d . Registro PC= %d ",test_idx, curr_addr);

    // reset
    rst = 1'b1;
    #25; test_idx++;
    $display("%d. Registro PC= %d ",test_idx, curr_addr);

    $finish;
    $display("-- Testbench completed --");

  end

endmodule
