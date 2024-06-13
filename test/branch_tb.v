`include "src/branch.v"

module branch_tb;

  reg [2:0] op = 3'b000;
  reg flag_z = 1'b0;
  reg flag_c = 1'b0;
  reg ctrl_jmp = 1'b0;

  wire branch;

  integer test_idx = 0;

  branch UUT(
    .op_i(op), .flag_z_i(flag_z), .flag_c_i(flag_c),
    .ctrl_jmp_i(ctrl_jmp), .branch_o(branch)
  );

  initial begin
    $dumpfile("bin/branch.vcd");
    $dumpvars(0, branch_tb);


    // Inicio de Señales
    $display("-- Inicia Simulación --");
    $display("--------------------------------------");
    $display("|  Op  Zero  Carry  ctrl_jmp  branch |");
    $display("--------------------------------------");

    // should branch; unconditional jump
    op = 3'b100;  // JMP
    flag_z = 1'b0;
    flag_c = 1'b0;
    ctrl_jmp = 1'b1;
    #10;  // delay de 10 unidades de tiempo (tiempo de reloj)
    test_idx++; 
    $display("|   %d    %d     %d        %d        %d   |", op, flag_z, flag_c, ctrl_jmp, branch);
   
    // should not branch; no control line not set
    op = 3'b100;  // JMP
    flag_z = 0;
    flag_c = 0;
    ctrl_jmp = 0;
    #10;  // delay de 10 unidades de tiempo (tiempo de reloj)
    test_idx++;   
    $display("|   %d    %d     %d        %d        %d   |", op, flag_z, flag_c, ctrl_jmp, branch);


    // should not branch; non-branching opcode
    op = 3'b010;  // LDA
    flag_z = 0;
    flag_c = 0;
    ctrl_jmp = 1;
    #10; test_idx++;
    $display("|   %d    %d     %d        %d        %d   |", op, flag_z, flag_c, ctrl_jmp, branch);

    // should branch; unconditional JZ
    op = 3'b101;  // JZ
    flag_z = 1;
    flag_c = 0;
    ctrl_jmp = 1;
    #10; test_idx++;
    $display("|   %d    %d     %d        %d        %d   |", op, flag_z, flag_c, ctrl_jmp, branch);


    // should not branch; no control line not set
    op = 3'b101;  // JZ
    flag_z = 1;
    flag_c = 0;
    ctrl_jmp = 0;
    #10; test_idx++;
    $display("|   %d    %d     %d        %d        %d   |", op, flag_z, flag_c, ctrl_jmp, branch);

    // should branch; JC and C flag set
    op = 3'b110;  // JC
    flag_z = 0;
    flag_c = 1;
    ctrl_jmp = 1;
    #10; test_idx++;
    $display("|   %d    %d     %d        %d        %d   |", op, flag_z, flag_c, ctrl_jmp, branch);


    // should not branch; C flag set not set for JC
    op = 3'b110;  // JC
    flag_z = 0;
    flag_c = 0;
    ctrl_jmp = 1;
    #10; test_idx++;
    $display("|   %d    %d     %d        %d        %d   |", op, flag_z, flag_c, ctrl_jmp, branch);
  

   $display("--------------------------------------");
   $display("-- Testbench completed --");
   $finish;
  end

endmodule
