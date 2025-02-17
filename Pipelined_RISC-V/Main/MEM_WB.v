`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2025 00:43:57
// Design Name: 
// Module Name: MEM_WB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB(
    input clk,
    input reset,
    input [31:0] read_data,
    input [31:0] alu_result_EX_MEM,
    input [4:0] rd_EX_MEM,
    input memtoreg_EX_MEM,
    
    output reg [31:0] read_data_MEM_WB,
    output reg [31:0] alu_result_MEM_WB,
    output reg [4:0] rd_MEM_WB,
    output reg memtoreg_MEM_WB
);
    
    always @(posedge clk, posedge reset)
    begin
        if(reset) begin
            read_data_MEM_WB    <= 0;
            alu_result_MEM_WB   <= 0;
            rd_MEM_WB           <= 0;
            memtoreg_MEM_WB     <= 0;
        end
        else begin
            read_data_MEM_WB    <= read_data;
            alu_result_MEM_WB   <= alu_result_EX_MEM;
            rd_MEM_WB           <= rd_EX_MEM;
            memtoreg_MEM_WB     <= memtoreg_EX_MEM;
        end
    end
    
endmodule

