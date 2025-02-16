`timescale 1ns / 1ps


module add(
    input [31:0] a,
    input [31:0] b,
    input [31:0] add_out
    );
    assign add_out = a + b;
endmodule
