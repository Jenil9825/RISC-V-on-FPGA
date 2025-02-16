`timescale 1ns / 1ps

module alu_control (
    input wire [1:0] aluop,    // ALU Operation control
    input wire [2:0] funct3,   // Function 3 bits from instruction
    input wire funct7,   // Function 7 bits from instruction
    output reg [3:0] alu_ctr   // ALU control signal
);
    initial begin
    alu_ctr <= 32'b0;
    end
    
always @(*) begin
    case (aluop)
        2'b00: alu_ctr <= 4'b0010;
        
        2'b01: begin // Branch Instructions
            case (funct3)
                3'b000: alu_ctr <= 4'b0110; // beq
                3'b001: alu_ctr <= 4'b0100; // bne
                3'b100: alu_ctr <= 4'b0100; // blt
                3'b101: alu_ctr <= 4'b0110; // bge
                default: alu_ctr <= 4'b0000; // Default (AND)
            endcase
        end

        2'b10: begin // R-Type Instructions
            case ({funct7, funct3}) // ✅ FIXED: Using `funct7[5]` as a single-bit
                4'b0000: alu_ctr <= 4'b0010; // ADD
                4'b1000: alu_ctr <= 4'b0110; // SUB
                4'b0111: alu_ctr <= 4'b0000; // AND
                4'b0110: alu_ctr <= 4'b0001; // OR
                default: alu_ctr <= 4'b0000;
            endcase
        end

        default: alu_ctr <= 4'b0000;
    endcase
end

endmodule
