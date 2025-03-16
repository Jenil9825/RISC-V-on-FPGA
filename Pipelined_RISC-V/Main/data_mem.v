`timescale 1ns / 1ps

module data_mem (
    input wire clk,
    input wire reset,
    input wire memwrite,      
    input wire memread,       
    input wire [31:0] address,
    input wire [31:0] write_data,
    output reg [31:0] read_data 
);

    reg [31:0] memory [0:31];

    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                memory[i] <= 32'b0;
        end 
        else if (memwrite) begin
            memory[address[11:2]] <= write_data;
        end
    end

    always @(*) begin
        if (memread)
            read_data = memory[address[11:2]];
        else
            read_data = 32'b0;
    end

endmodule