`timescale 1ns / 1ps

module registers (
    input wire clk,      
    input wire reset,         
    input wire reg_write,       
    input wire [4:0] read_reg1,
    input wire [4:0] read_reg2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

    // Register file: 32 registers of 32-bit each
    reg [31:0] reg_file [0:31];
        
    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_file[0]  <= 32'h0000000c;
            reg_file[1]  <= 32'h0000000d;
            
            for(i=2; i<=31; i=i+1)begin
            reg_file[i] <= 32'b0;
            end
        end 
        else if (reg_write) begin
            reg_file[write_reg] <= write_data;
        end
    end

    always @(*) begin
        read_data1 = reg_file[read_reg1];
        read_data2 = reg_file[read_reg2];
    end

endmodule
