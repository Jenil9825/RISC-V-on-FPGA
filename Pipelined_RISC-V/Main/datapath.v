`timescale 1ns / 1ps

module datapath(
    input wire clk,
    input wire reset,
    output [3:0] out  // ✅ Changed to 'reg' to prevent multi-driven net
);

    // Internal signals
    wire [31:0] pc_out, pc_in, add_alu_out, add_pc_out;
    wire [31:0] instruction;
    wire [31:0] read_data1, read_data2, immout;
    wire [31:0] alu_input, write_data, read_data;
    wire [31:0] alu_result;
    wire z_flag;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;
    wire funct7;
    wire [2:0] funct3;
    
    // Piplined Internal Signals
    wire [31:0] pc_out_IF_ID, instruction_IF_ID;
    
    wire branch_ID_EX;              
    wire memread_ID_EX;             
    wire memtoreg_ID_EX;            
    wire [1:0] aluop_ID_EX;         
    wire memwrite_ID_EX;            
    wire alusrc_ID_EX;              
    wire regwrite_ID_EX;            
    wire [31:0] read_data1_ID_EX;   
    wire [31:0] read_data2_ID_EX;   
    wire [31:0] pc_out_ID_EX; 
    wire [31:0] immout_ID_EX;       
    wire [2:0] funct3_ID_EX;        
    wire funct7_ID_EX;
    wire [4:0] rd_ID_EX; 
    
    wire [31:0] pc_out_EX_MEM;
    wire [31:0] alu_result_EX_MEM;
    wire branch_EX_MEM;
    wire memread_EX_MEM;
    wire [31:0] read_data2_EX_MEM;
    wire memtoreg_EX_MEM;
    wire memwrite_EX_MEM;
    wire regwrite_EX_MEM;
    wire z_flag_EX_MEM;
    wire [4:0] rd_EX_MEM; 
    wire [31:0] add_alu_out_EX_MEM;
    
    wire [31:0] read_data_MEM_WB;
    wire [31:0] alu_result_MEM_WB;
    wire [4:0] rd_MEM_WB;
    wire memtoreg_MEM_WB;
    
    
    // Control signals
    wire branch, memread, memtoreg, memwrite, alusrc, regwrite;
    wire [1:0] aluop;
    wire [3:0] alu_control;
    wire c_flag, n_flag, v_flag;
    
        // Decode instruction
    assign opcode = instruction_IF_ID[6:0];
    assign rs1 = instruction_IF_ID[19:15];
    assign rs2 = instruction_IF_ID[24:20];
    assign rd = instruction_IF_ID[11:7]; 
    assign funct3 = instruction_IF_ID[14:12];
    assign funct7 = instruction_IF_ID[30];
//    clock_slow ck(
    
//        .clk(clk_signal),
//        .reset(reset),
//        .clock(clock)
//    );
    // Program Counter (PC)
    pc PC (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );
    
    // IF_ID
    IF_ID if_id(
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .instruction(instruction),
        .pc_out_IF_ID(pc_out_IF_ID),
        .instruction_IF_ID(instruction_IF_ID)
    );
    //ID_EX
    ID_EX id_ex (
        .clk(clk),
        .reset(reset),
        .branch(branch),
        .memread(memread),
        .memtoreg(memtoreg),
        .aluop(aluop),
        .memwrite(memwrite),
        .alusrc(alusrc),
        .regwrite(regwrite),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .pc_out_IF_ID(pc_out_IF_ID),
        .immout(immout),
        .funct3(funct3),
        .funct7(funct7),
        .rd(rd),
        .branch_ID_EX(branch_ID_EX),
        .memread_ID_EX(memread_ID_EX),
        .memtoreg_ID_EX(memtoreg_ID_EX),
        .aluop_ID_EX(aluop_ID_EX),
        .memwrite_ID_EX(memwrite_ID_EX),
        .alusrc_ID_EX(alusrc_ID_EX),
        .regwrite_ID_EX(regwrite_ID_EX),
        .read_data1_ID_EX(read_data1_ID_EX),
        .read_data2_ID_EX(read_data2_ID_EX),
        .pc_out_ID_EX(pc_out_ID_EX),
        .immout_ID_EX(immout_ID_EX),
        .funct3_ID_EX(funct3_ID_EX),
        .funct7_ID_EX(funct7_ID_EX),
        .rd_ID_EX(rd_ID_EX)
    );
    
    //EX_MEM
    EX_MEM ex_mem (
        .clk(clk),
        .reset(reset),
        .pc_out_ID_EX(pc_out_ID_EX),
        .alu_result(alu_result),
        .z_flag(z_flag),
        .branch_ID_EX(branch_ID_EX),
        .memread_ID_EX(memread_ID_EX),
        .memtoreg_ID_EX(memtoreg_ID_EX),
        .memwrite_ID_EX(memwrite_ID_EX),
        .regwrite_ID_EX(regwrite_ID_EX),
        .rd_ID_EX(rd_ID_EX),
        .add_alu_out(add_alu_out),
        .add_alu_out_EX_MEM(add_alu_out_EX_MEM),
        .pc_out_EX_MEM(pc_out_EX_MEM),
        .alu_result_EX_MEM(alu_result_EX_MEM),
        .branch_EX_MEM(branch_EX_MEM),
        .memread_EX_MEM(memread_EX_MEM),
        .memtoreg_EX_MEM(memtoreg_EX_MEM),
        .memwrite_EX_MEM(memwrite_EX_MEM),
        .regwrite_EX_MEM(regwrite_EX_MEM),
        .z_flag_EX_MEM(z_flag_EX_MEM),
        .rd_EX_MEM(rd_EX_MEM),
        .read_data2_ID_EX(read_data2_ID_EX),
        .read_data2_EX_MEM(read_data2_EX_MEM)
    );
    
    //MEM_WB
    MEM_WB mem_wb (
        .clk(clk),
        .reset(reset),
        .read_data(read_data),
        .alu_result_EX_MEM(alu_result_EX_MEM),
        .rd_EX_MEM(rd_EX_MEM),
        .memtoreg_EX_MEM(memtoreg_EX_MEM),
        .read_data_MEM_WB(read_data_MEM_WB),
        .alu_result_MEM_WB(alu_result_MEM_WB),
        .rd_MEM_WB(rd_MEM_WB),
        .memtoreg_MEM_WB(memtoreg_MEM_WB)
        );
        
        
    // Instruction Memory
    instruction_memory imem (
        .reset(reset),
        .pc_out(pc_out_IF_ID),
        .instruction(instruction)
    );


    // Control Unit
    control_unit ctrl_unit (
        .opcode(opcode),
        .branch(branch),
        .memread(memread),
        .memtoreg(memtoreg),
        .aluop(aluop),
        .memwrite(memwrite),
        .alusrc(alusrc),
        .regwrite(regwrite)
    );

    // Immediate Generator
    imm_gen imm_gen (
        .instruction(instruction_IF_ID),
        .immout(immout)
    );

    // Adders
    add_pc pc_adder (
        .pc_out(pc_out),
        .add_pc_out(add_pc_out)
    );

    add branch_adder (
        .a(pc_out_ID_EX),
        .b(immout_ID_EX),
        .add_out(add_alu_out)
    );

    // Register File
    registers reg_file (
        .reset(reset),
        .clk(clk),
        .reg_write(regwrite),
        .read_reg1(instruction[19:15]),
        .read_reg2(instruction[24:20]),
        .write_reg(instruction[6:0]),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ALU Input MUX
    mux mux_alu_in (
        .b(read_data2_ID_EX),
        .a(immout_ID_EX),
        .sel(alusrc_ID_EX),
        .mux_out(alu_input)
    );

    // ALU
    alu alu (
        .I1(read_data1_ID_EX),
        .I2(alu_input),
        .alu_ctr(alu_control),
        .alu_out(alu_result),
        .n_flag(n_flag),
        .z_flag(z_flag),
        .c_flag(c_flag),
        .v_flag(v_flag)
    );

    // ALU Control Unit
    alu_control alu_ctrl (
        .aluop(aluop_ID_EX),
        .funct3(funct3_ID_EX),
        .funct7(funct7_ID_EX),
        .alu_ctr(alu_control)
    );

    // Data Memory
    data_mem data_mem (
        .reset(reset),
        .clk(clk),
        .address(alu_result_EX_MEM),
        .write_data(read_data2_EX_MEM),
        .memwrite(memwrite_EX_MEM),
        .memread(memread_EX_MEM),
        .read_data(read_data)
    );

    // MUX for Memory to Register (MemtoReg)
    mux mux_data_mem (
        .b(alu_result_MEM_WB),
        .a(read_data_MEM_WB),
        .sel(memtoreg_MEM_WB),
        .mux_out(write_data)
    );

    wire c;
    assign c = z_flag_EX_MEM && branch_EX_MEM;

    mux mux_pc (
        .a(add_alu_out_EX_MEM),
        .b(add_pc_out),
        .sel(c),
        .mux_out(pc_in) 
    );
    assign out = alu_result_MEM_WB [3:0];

endmodule
