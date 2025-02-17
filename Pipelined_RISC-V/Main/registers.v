`timescale 1ns / 1ps

module registers (
    input wire clk,             // Clock signal
    input wire reset,           // Active-high reset
    input wire reg_write,       // Write enable signal
    input wire [4:0] read_reg1, // Read register 1 address
    input wire [4:0] read_reg2, // Read register 2 address
    input wire [4:0] write_reg, // Write register address
    input wire [31:0] write_data, // Data to be written
    output reg [31:0] read_data1, // Output of Read Register 1
    output reg [31:0] read_data2  // Output of Read Register 2
);

    // Register file: 32 registers of 32-bit each
    reg [31:0] reg_file [0:31];
        
    integer i;
    // ✅ Synchronous write operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_file[0]  <= 32'h0000000c;  // x0 must always be 0
            reg_file[1]  <= 32'h0000000d;
            
            for(i=2; i<=31; i=i+1)begin
            reg_file[i] <= 32'b0;
            end
        end 
        else if (reg_write) begin
            reg_file[write_reg] <= write_data; // Write data to register (except x0)
        end
    end

    // ✅ Asynchronous read operation
    always @(*) begin
        read_data1 = reg_file[read_reg1]; // Read register 1
        read_data2 = reg_file[read_reg2]; // Read register 2
    end

endmodule
