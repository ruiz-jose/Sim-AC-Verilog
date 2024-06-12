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
    $display("-----------------------------------------------");
    $display("|            Test   Reset   Jmp   Registro PC |");
    $display("-----------------------------------------------");


    // reset
    rst = 1'b1;
    jmp_en = 1'b0;
    #10;  // delay de 10 unidades de tiempo (tiempo de reloj)
    test_idx++;
    $display("|   %d       %d      %d       %d       |", test_idx, rst, jmp_en, curr_addr);
    
    // not reset
    rst = 0;
    jmp_en = 0;
    #10; test_idx++;
    $display("|   %d       %d      %d       %d       |", test_idx, rst, jmp_en, curr_addr);
    
    #10; test_idx++;
    $display("|   %d       %d      %d       %d       |", test_idx, rst, jmp_en, curr_addr);

    #10; test_idx++;
    $display("|   %d       %d      %d       %d       |", test_idx, rst, jmp_en, curr_addr);

    // jump
    rst = 0;
    jmp_en = 1;  // mientras este en 1, el PC se va a mover a la direccion jmp_addr   
    jmp_addr = 5'b11001;  //19h 25d
    #10; test_idx++;  // 
    $display("|   %d       %d      %d       %d       |", test_idx, rst, jmp_en, curr_addr);

    // reset
    rst = 1;
    jmp_en = 0;
    #10; test_idx++;
    $display("|   %d       %d      %d       %d       |", test_idx, rst, jmp_en, curr_addr);

    // not reset
    rst = 0;
    jmp_en = 0;
    #10; test_idx++;
    $display("|   %d       %d      %d       %d       |", test_idx, rst, jmp_en, curr_addr);
    
    #10; test_idx++;
    $display("|   %d       %d      %d       %d       |", test_idx, rst, jmp_en, curr_addr);

    $display("-----------------------------------------------");

    $display("-- Testbench completed --");
    $finish;

  end

endmodule
