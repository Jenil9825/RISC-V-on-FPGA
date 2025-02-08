module imm_gen(
    input wire [31:0] instruction,
    output reg [31:0] immOut
);
    always @(*) begin
        case (instruction[6:0]) // Opcode field (instruction[6:0])
            // I-Type Instructions (e.g., lw, lb, lh, lbu, lhu)
            7'b0000011: begin
                immOut = {{20{instruction[31]}}, instruction[31:20]}; 
            end

            // S-Type Instructions (e.g., sw, sb, sh)
            7'b0100011: begin
                immOut = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end

            // SB-Type (B-Type) Instructions (e.g., beq, bne)
            7'b1100011: begin
                immOut = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; 
            end

            // U-Type Instructions (e.g., LUI, AUIPC)
            7'b0110111, // LUI
            7'b0010111: begin // AUIPC
                immOut = {instruction[31:12], 12'b0}; 
            end

            // UJ-Type Instructions (e.g., JAL)
            7'b1101111: begin
                immOut = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; 
            end

            default: begin
                immOut = 32'b0; 
            end
        endcase
    end
endmodule