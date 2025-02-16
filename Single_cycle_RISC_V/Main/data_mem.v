`timescale 1ns / 1ps

module data_mem (
    input wire clk,
    input wire reset,
    input wire memwrite,       // Memory write enable
    input wire memread,        // Memory read enable
    input wire [31:0] address, // Memory address
    input wire [31:0] write_data, // Data to be written
    output reg [31:0] read_data // Data read from memory
);
    // Memory size: 32 words (32-bit each)
    reg [31:0] memory [0:31];

    integer i;

    // ✅ Reset logic: Initialize memory on reset (Synchronous)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                memory[i] <= 32'b0; // Clear memory
        end 
        else if (memwrite) begin
            memory[address[11:2]] <= write_data; // Write to memory (word-aligned)
        end
    end

    // ✅ Read operation (Combinational)
    always @(*) begin
        if (memread)
            read_data = memory[address[11:2]]; // Read from memory (word-aligned)
        else
            read_data = 32'b0;
    end

endmodule
