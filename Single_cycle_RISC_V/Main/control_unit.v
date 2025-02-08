module control_unit(
    input [6:0] opcode,           
    output reg Branch,          
    output reg MemRead,         
    output reg MemtoReg,         
    output reg [1:0] ALUOp,      
    output reg MemWrite,        
    output reg ALUSrc,           
    output reg RegWrite          
);

    always @(*) begin
        // Default values for all control signals
        Branch    = 1'b0;
        MemRead   = 1'b0;
        MemtoReg  = 1'b0;
        ALUOp     = 2'b00;
        MemWrite  = 1'b0;
        ALUSrc    = 1'b0;
        RegWrite  = 1'b0;

        // Decode control signals based on opcode
        case (opcode)
            7'b0110011: begin // R-type instruction
                ALUSrc   = 1'b0;    
                MemtoReg = 1'b0;   
                RegWrite = 1'b1;    
                MemRead  = 1'b0;    
                MemWrite = 1'b0;    
                Branch   = 1'b0;    
                ALUOp    = 2'b10;   
            end
            7'b0000011: begin // Load word (lw)
                ALUSrc   = 1'b1;    
                MemtoReg = 1'b1;    
                RegWrite = 1'b1;    
                MemRead  = 1'b1;    
                MemWrite = 1'b0;    
                Branch   = 1'b0;    
                ALUOp    = 2'b00;   
            end
            7'b0100011: begin // Store word (sw)
                ALUSrc   = 1'b1;    
                MemtoReg = 1'bX;    
                RegWrite = 1'b0;    
                MemRead  = 1'b0;    
                MemWrite = 1'b1;    
                Branch   = 1'b0;    
                ALUOp    = 2'b00;   
            end
            7'b1100011: begin // Branch equal (beq)
                ALUSrc   = 1'b0;    
                MemtoReg = 1'bX;    
                RegWrite = 1'b0;    
                MemRead  = 1'b0;    
                MemWrite = 1'b0;    
                Branch   = 1'b1;    
                ALUOp    = 2'b01;   
            end
            default: begin
                // Default case ensures all signals are disabled
                Branch    = 1'b0;
                MemRead   = 1'b0;
                MemtoReg  = 1'b0;
                ALUOp     = 2'b00;
                MemWrite  = 1'b0;
                ALUSrc    = 1'b0;
                RegWrite  = 1'b0;
            end
        endcase
    end

endmodule