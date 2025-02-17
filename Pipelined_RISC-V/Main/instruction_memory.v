`timescale 1ns / 1ps

module instruction_memory (
    input reset,
    input wire [31:0] pc_out,     // Address from Program Counter (PC)
    output reg [31:0] instruction // 32-bit instruction output
);

    // Instruction Memory (ROM) - 32 Words (128 Bytes)
    reg [31:0] Memory [0:31];

    integer i;

    // ✅ Initialize memory to zero and load instructions
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            Memory[i] = 32'b0; // Initialize all memory locations to 0
        end
        // funct7_rs2_rs1_funct3_rd_opcode
        // ✅ Load predefined instructions (example RISC-V instructions)
        Memory[0] = 32'h00000013; // NOP (ADDI x0, x0, 0)
        Memory[1] = 32'b0000000_00001_00010_000_00011_0110011; // ADD
        Memory[2] = 32'b0000000_00010_00011_000_00100_0110011; 
        Memory[3] = 32'b0000000_00011_00100_000_00101_0110011; 
        Memory[4] = 32'b0000000_00100_00101_000_00111_0110011; 
        Memory[5] = 32'b0000000_00101_00110_000_01000_0110011; 
        Memory[6] = 32'b0000000_00110_00111_000_01001_0110011; 
        Memory[7] = 32'b0000000_00111_01000_000_01011_0110011; 
        Memory[8] = 32'b0000000_01000_01000_000_01100_0110011;

        for (i = 9; i < 32; i = i + 1)
            Memory[i] <= 32'h00000013; // NOP
    end

    // ✅ Single Always Block to Avoid Multiple Drivers
    always @(*) begin
        if (reset)
            instruction = 32'b0;
        else
            instruction = Memory[pc_out[6:2]]; // Fetch instruction (word-aligned)
    end

endmodule
