`timescale 1ns / 1ps

module imm_gen (
    input wire [31:0] instruction,  // 32-bit RISC-V instruction
    output reg [31:0] immout        // 32-bit sign-extended immediate output
);

    always @(*) begin
        case (instruction[6:0])  // Opcode field (bits [6:0])
        
            // ✅ I-Type Instructions (LW, ADDI, ANDI, ORI, XORI, SLTI, SLTIU, JALR)
            7'b0000011, // Load Instructions (LW, LB, LH, LBU, LHU)
            7'b0010011, // ALU Immediate Instructions (ADDI, ANDI, ORI, XORI, SLTI, SLTIU)
            7'b1100111: // JALR (Jump and Link Register)
                immout = {{20{instruction[31]}}, instruction[31:20]}; // Sign-extend bits [31:20]
            
            // ✅ S-Type Instructions (SW, SH, SB)
            7'b0100011: 
                immout = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // Sign-extend bits [31:25] and [11:7]

            // ✅ SB-Type (Branch Instructions: BEQ, BNE, BLT, BGE, BLTU, BGEU)
            7'b1100011: 
                immout = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}; // Sign-extend bits with correct order

            // ✅ U-Type Instructions (LUI, AUIPC)
            7'b0110111, // LUI (Load Upper Immediate)
            7'b0010111: // AUIPC (Add Upper Immediate to PC)
                immout = {instruction[31:12], 12'b0}; // Zero-extended upper immediate

            // ✅ UJ-Type (JAL - Jump and Link)
            7'b1101111: 
                immout = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // Correct immediate extraction

            default: 
                immout = 32'b0; // Default case ensures no undefined behavior
        endcase
    end

endmodule
