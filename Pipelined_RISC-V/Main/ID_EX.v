`timescale 1ns / 1ps


module ID_EX(
    input clk,
    input reset,
    input branch,          
    input memread,         
    input memtoreg,         
    input [1:0] aluop,      
    input memwrite,        
    input alusrc,           
    input regwrite,
    input [31:0] read_data1,
    input [31:0] read_data2,
    input [31:0] pc_out_IF_ID,
    input [31:0] immout,
    input [2:0] funct3,         
    input funct7,  
    input [4:0] rd,
    input [4:0] rs1,
    input [4:0] rs2,
    input [31:0] pc_out_reg,
    input [1:0] pc_sel,
    output reg [1:0] pc_sel_ID_EX,
    output reg [31:0] pc_out_reg_ID_EX,
    output reg branch_ID_EX,              
    output reg memread_ID_EX,             
    output reg memtoreg_ID_EX,            
    output reg [1:0] aluop_ID_EX,         
    output reg memwrite_ID_EX,            
    output reg alusrc_ID_EX,              
    output reg regwrite_ID_EX,            
    output reg [31:0] read_data1_ID_EX,   
    output reg [31:0] read_data2_ID_EX,   
    output reg [31:0] pc_out_ID_EX, 
    output reg [31:0] immout_ID_EX,       
    output reg [2:0] funct3_ID_EX,        
    output reg funct7_ID_EX,
    output reg [4:0] rd_ID_EX, 
    output reg [4:0] rs1_ID_EX,
    output reg [4:0] rs2_ID_EX 
    );
    
    always @(posedge clk, posedge reset)
    begin
    if(reset) begin 
    branch_ID_EX        <= 0;          
    memread_ID_EX       <= 0;         
    memtoreg_ID_EX      <= 0;        
    aluop_ID_EX         <= 0;     
    memwrite_ID_EX      <= 0;        
    alusrc_ID_EX        <= 0;          
    regwrite_ID_EX      <= 0;        
    read_data1_ID_EX    <= 0;
    read_data2_ID_EX    <= 0;
    pc_out_ID_EX        <= 0;   
    immout_ID_EX        <= 0;   
    funct3_ID_EX        <= 0;    
    funct7_ID_EX        <= 0;    
    rd_ID_EX            <= 0;
    rs1_ID_EX            <= 0;
    rs2_ID_EX            <= 0;    
    pc_out_reg_ID_EX    <=0;     
    pc_sel_ID_EX             <=0;
    end
    else begin
    branch_ID_EX        <= branch;
    memread_ID_EX       <= memread;
    memtoreg_ID_EX      <= memtoreg;
    aluop_ID_EX         <= aluop;
    memwrite_ID_EX      <= memwrite;
    alusrc_ID_EX        <= alusrc;
    regwrite_ID_EX      <= regwrite;       
    read_data1_ID_EX    <= read_data1; 
    read_data2_ID_EX    <= read_data2;
    pc_out_ID_EX        <= pc_out_IF_ID;    
    immout_ID_EX        <= immout;    
    funct3_ID_EX        <= funct3;    
    funct7_ID_EX        <= funct7;  
    rd_ID_EX            <= rd; 
    rs1_ID_EX            <= rs1; 
    rs2_ID_EX            <= rs2; 
    pc_out_reg_ID_EX    <= pc_out_reg;
    pc_sel_ID_EX        <=pc_sel;
    end
    end
    
    endmodule
