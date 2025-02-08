module ALU_Control(
    input [1:0] ALUOp,          
    input [2:0] funct3,         
    input funct7,               
    output reg [3:0] alu_ctr    
);

    always @(*) begin
        case (ALUOp)
            2'b00: begin // Load/Store or Immediate Arithmetic
                alu_ctr = 4'b0010; // ADD (default for address computation)
            end
            2'b01: begin // Branch Instructions
                case (funct3)
                    3'b000: alu_ctr = 4'b0110; // SUB (beq)
                    3'b001: alu_ctr = 4'b0110; // SUB (bne)
                    default: alu_ctr = 4'b0000; 
                endcase
            end
            2'b10: begin // R-Type Instructions
                case ({funct7, funct3})
                    4'b0000: alu_ctr = 4'b0010; // ADD
                    4'b1000: alu_ctr = 4'b0110; // SUB
                    4'b0111: alu_ctr = 4'b0000; // AND
                    4'b0110: alu_ctr = 4'b0001; // OR
                    4'b0100: alu_ctr = 4'b1000; // XOR
                    default: alu_ctr = 4'b0000;
                endcase
            end
            default: begin
                alu_ctr = 4'b0000;
            end
        endcase
    end

endmodule