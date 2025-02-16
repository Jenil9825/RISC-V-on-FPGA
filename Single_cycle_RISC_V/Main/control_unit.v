`timescale 1ns / 1ps

module control_unit(
    input wire [6:0] opcode,  // 7-bit opcode from instruction
    output reg branch,        
    output reg memread,       
    output reg memtoreg,      
    output reg [1:0] aluop,   
    output reg memwrite,      
    output reg alusrc,        
    output reg regwrite       
);

    always @(*) begin
        // Default values (safe state)
        branch    = 1'b0;
        memread   = 1'b0;
        memtoreg  = 1'b0;
        aluop     = 2'b00;
        memwrite  = 1'b0;
        alusrc    = 1'b0;
        regwrite  = 1'b0;

        case (opcode)
            7'b0110011: begin // R-type (ADD, SUB, AND, OR, etc.)
                alusrc   = 1'b0;    
                memtoreg = 1'b0;    
                regwrite = 1'b1;    
                memread  = 1'b0;    
                memwrite = 1'b0;    
                branch   = 1'b0;    
                aluop    = 2'b10;   
            end
            7'b0000011: begin // Load Word (LW)
                alusrc   = 1'b1;    
                memtoreg = 1'b1;    
                regwrite = 1'b1;    
                memread  = 1'b1;    
                memwrite = 1'b0;    
                branch   = 1'b0;    
                aluop    = 2'b00;   
            end
            7'b0100011: begin // Store Word (SW)
                alusrc   = 1'b1;    
                memtoreg = 1'b1;    // Store doesn't use MemtoReg
                regwrite = 1'b0;    
                memread  = 1'b0;    
                memwrite = 1'b1;    
                branch   = 1'b0;    
                aluop    = 2'b00;   
            end
            7'b1100011: begin // Branch Equal (BEQ)
                alusrc   = 1'b0;    
                memtoreg = 1'b0;    // Branch doesn't use MemtoReg
                regwrite = 1'b0;    
                memread  = 1'b0;    
                memwrite = 1'b0;    
                branch   = 1'b1;    
                aluop    = 2'b01;   
            end
            7'b0010011: begin // I-type ALU (ADDI, ANDI, ORI, etc.)
                alusrc   = 1'b1;    
                memtoreg = 1'b0;    
                regwrite = 1'b1;    
                memread  = 1'b0;    
                memwrite = 1'b0;    
                branch   = 1'b0;    
                aluop    = 2'b10;   
            end
            7'b1101111: begin // Jump and Link (JAL)
                alusrc   = 1'b1;    
                memtoreg = 1'b0;    
                regwrite = 1'b1;    
                memread  = 1'b0;    
                memwrite = 1'b0;    
                branch   = 1'b1;    
                aluop    = 2'b00;   
            end
            default: begin
                // Ensure all control signals remain safe in unknown states
                branch    = 1'b0;
                memread   = 1'b0;
                memtoreg  = 1'b0;
                aluop     = 2'b00;
                memwrite  = 1'b0;
                alusrc    = 1'b0;
                regwrite  = 1'b0;
            end
        endcase
    end

endmodule
