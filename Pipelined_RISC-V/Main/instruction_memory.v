`timescale 1ns / 1ps

module instruction_memory (
    input reset,
    input wire [31:0] pc_out,     // Address from Program Counter (PC)
    output reg [31:0] instruction // 32-bit instruction output
);

    // Instruction Memory (ROM) - 32 Words (128 Bytes)
    reg [31:0] Memory [0:31];

    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            Memory[i] = 32'b0; // Initialize all memory locations to 0
        end
        // funct7_rs2_rs1_funct3_rd_opcode
        Memory[0] = 32'b0000000_00010_00001_000_00011_0110011; 
        Memory[1] = 32'b0000000_00011_00010_000_00100_0110011; 
        Memory[2] = 32'b0000000_00100_00011_000_00101_0110011; 
        // immediate_rs1_funct3_rd_opcode (JAL Operation)
        Memory[3] = 32'b000010001000_00101_000_00110_1101111;
        Memory[4] = 32'b0000000_00110_00101_000_00111_0110011; 
        Memory[5] = 32'b0000000_00111_00110_000_01000_0110011; 
        Memory[6] = 32'b0000000_01000_00111_000_01001_0110011;
        // immediate_rs1_funct3_rd_opcode (JALR instruction)
        Memory[7] = 32'b000000111011_00001_000_00101_1100111;
        Memory[8] = 32'b0000000_01001_01000_000_01010_0110011;
        for (i = 9; i < 32; i = i + 1)
            Memory[i] <= 32'h00000013; // NOP
    end

    always @(*) begin
        if (reset)
            instruction = 32'b0;
        else
            instruction = Memory[pc_out[6:2]];
    end

endmodule