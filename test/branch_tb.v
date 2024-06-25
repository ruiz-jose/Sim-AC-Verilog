`include "src/branch.v"

module branch_tb;

  reg [2:0] op = 3'b000;
  reg [1:0]flags = 2'b00;
  reg ctrl_jmp = 1'b0;

  wire branch;

  integer test_idx = 0;

  branch UUT(
    .op_i(op), .flags_i(flags),
    .ctrl_jmp_i(ctrl_jmp), .branch_o(branch)
  );

  initial begin
    $dumpfile("bin/branch.vcd");
    $dumpvars(0, branch_tb);


    // Inicio de Señales
    $display("-- Inicia Simulación --");
    $display("--------------------------------------");
    $display("|  Op  Carry  Zero  ctrl_jmp  branch |");
    $display("--------------------------------------");

    // should branch; unconditional jump
    op = 3'b100;  // JMP
    flags = 2'b00;
    ctrl_jmp = 1'b1;
    #10;  // delay de 10 unidades de tiempo (tiempo de reloj)
    test_idx++; 
    $display("|   %d    %b     %b        %d        %d   |", op, flags[1], flags[0], ctrl_jmp, branch);
   
    // should not branch; no control line not set
    op = 3'b100;  // JMP
    ctrl_jmp = 0;
    #10;  // delay de 10 unidades de tiempo (tiempo de reloj)
    test_idx++;   
    $display("|   %d    %b     %b        %d        %d   |", op, flags[1], flags[0], ctrl_jmp, branch);


    // should not branch; non-branching opcode
    op = 3'b010;  // LDA
    ctrl_jmp = 1;
    #10; test_idx++;
    $display("|   %d    %b     %b        %d        %d   |", op, flags[1], flags[0], ctrl_jmp, branch);

    // should branch; unconditional JZ
    op = 3'b101;  // JZ
    flags = 2'b01;
    ctrl_jmp = 1;
    #10; test_idx++;
    $display("|   %d    %b     %b        %d        %d   |", op, flags[1], flags[0], ctrl_jmp, branch);


    // should not branch; no control line not set
    op = 3'b101;  // JZ
    ctrl_jmp = 0;
    #10; test_idx++;
    $display("|   %d    %b     %b        %d        %d   |", op, flags[1], flags[0], ctrl_jmp, branch);

    // should branch; JC and C flag set
    op = 3'b110;  // JC
    flags = 2'b10;
    ctrl_jmp = 1;
    #10; test_idx++;
    $display("|   %d    %b     %b        %d        %d   |", op, flags[1], flags[0], ctrl_jmp, branch);


    // should not branch; C flag set not set for JC
    op = 3'b110;  // JC
    flags = 2'b00;
    ctrl_jmp = 1;
    #10; test_idx++;
    $display("|   %d    %b     %b        %d        %d   |", op, flags[1], flags[0], ctrl_jmp, branch);
  

   $display("--------------------------------------");
   $display("-- Testbench completed --");
   $finish;
  end

endmodule
