`timescale 1ns / 1ps

module EX_MEM(
    input clk,
    input reset,
    input [31:0] alu_result,                  
    input z_flag,
    input branch_ID_EX,            
    input memread_ID_EX,           
    input memtoreg_ID_EX,                 
    input memwrite_ID_EX,                     
    input regwrite_ID_EX,   
    input [4:0] rd_ID_EX,
    input [31:0] add_alu_out,
    input [31:0] read_data2_ID_EX,
    
    output reg [31:0] read_data2_EX_MEM,
    output reg [31:0] add_alu_out_EX_MEM,
    output reg [31:0] alu_result_EX_MEM, 
    output reg branch_EX_MEM,
    output reg memread_EX_MEM,
    output reg memtoreg_EX_MEM,
    output reg memwrite_EX_MEM,
    output reg regwrite_EX_MEM,
    output reg z_flag_EX_MEM,
    output reg [4:0] rd_EX_MEM
);
    
    always @(posedge clk, posedge reset)
    begin
        if(reset) begin
            read_data2_EX_MEM  <= 0;
            add_alu_out_EX_MEM <= 0;
            alu_result_EX_MEM  <= 0;
            z_flag_EX_MEM      <= 0;
            branch_EX_MEM      <= 0;
            memread_EX_MEM     <= 0;
            memtoreg_EX_MEM   <= 0;
            memwrite_EX_MEM    <= 0;
            regwrite_EX_MEM    <= 0;
            rd_EX_MEM          <= 0;
        end
        else begin
            read_data2_EX_MEM  <= read_data2_ID_EX;
            add_alu_out_EX_MEM <= add_alu_out;
            alu_result_EX_MEM  <= alu_result;
            z_flag_EX_MEM      <= z_flag;
            branch_EX_MEM      <= branch_ID_EX;
            memread_EX_MEM     <= memread_ID_EX;
            memtoreg_EX_MEM   <= memtoreg_ID_EX;
            memwrite_EX_MEM    <= memwrite_ID_EX;
            regwrite_EX_MEM    <= regwrite_ID_EX;
            rd_EX_MEM          <= rd_ID_EX;
        end
    end
    
endmodule