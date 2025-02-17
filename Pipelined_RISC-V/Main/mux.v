`timescale 1ns / 1ps


module mux(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output [31:0] mux_out
    );
    
    assign mux_out = sel ? a : b;
    
endmodule
