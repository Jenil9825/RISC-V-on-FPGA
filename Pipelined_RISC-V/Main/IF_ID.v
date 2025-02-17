`timescale 1ns / 1ps


module IF_ID(
    input clk,
    input reset,
    input [31:0] pc_out,
    input [31:0] instruction,
    output reg [31:0] pc_out_IF_ID,
    output reg [31:0] instruction_IF_ID
    );
    
    always @(posedge clk, posedge reset)
    begin
    if(reset) begin 
        instruction_IF_ID <= 0;
        pc_out_IF_ID <=0; 
    end
        pc_out_IF_ID <= pc_out;
    instruction_IF_ID <= instruction;
    end
endmodule
