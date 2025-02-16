`timescale 1ns / 1ps


module add_pc(
    input [31:0] pc_out,
    output [31:0] add_pc_out
    );
    assign add_pc_out = pc_out + 32'b100;
endmodule
