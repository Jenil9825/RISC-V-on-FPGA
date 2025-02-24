`timescale 1ns / 1ps


module forwarding_unit(
    input wire [4:0] ID_EX_Rs1,     
    input wire [4:0] ID_EX_Rs2,     
    input wire [4:0] EX_MEM_Rd,     
    input wire [4:0] MEM_WB_Rd,     
    input wire EX_MEM_RegWrite,    
    input wire MEM_WB_RegWrite,     
    output reg [1:0] ForwardA,      
    output reg [1:0] ForwardB       
);

always @(*) begin
    ForwardA = 2'b00;
    ForwardB = 2'b00;

    if (EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs1)) 
        ForwardA = 2'b10; 
    
    if (EX_MEM_RegWrite && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs2)) 
        ForwardB = 2'b10;

    if (MEM_WB_RegWrite && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs1) && !(EX_MEM_RegWrite && (EX_MEM_Rd == ID_EX_Rs1))) 
        ForwardA = 2'b01;
        
    if (MEM_WB_RegWrite && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs2) && !(EX_MEM_RegWrite && (EX_MEM_Rd == ID_EX_Rs2))) 
        ForwardB = 2'b01;
end

endmodule

