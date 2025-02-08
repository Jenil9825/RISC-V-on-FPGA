module Add_ALU(
    input [31:0] PC_out,
    input [31:0] imm_gen,
    output [31:0] add_alu_out
    );
    assign add_alu_out = imm_gen + PC_out;
endmodule
