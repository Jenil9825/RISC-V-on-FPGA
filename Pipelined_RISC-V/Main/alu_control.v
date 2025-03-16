`timescale 1ns / 1ps

module alu_control (
    input wire [1:0] aluop, 
    input wire [2:0] funct3,
    input wire funct7,
    input wire [6:0] opcode,
    output reg [3:0] alu_ctr
);
    initial begin
    alu_ctr <= 32'b0;
    end
    
always @(*) begin
             if(opcode == 7'b1101111) begin
                alu_ctr <= 4'b1010;
         end else if (opcode == 7'b1100111) begin
                alu_ctr <= 4'b1011;
         end else begin
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
            case ({funct7, funct3})
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
end

endmodule
