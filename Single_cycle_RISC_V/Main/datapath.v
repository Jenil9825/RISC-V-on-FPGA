`timescale 1ns / 1ps

module datapath(
    input wire clk,
    input wire reset,
    output [3:0] out  // ✅ Changed to 'reg' to prevent multi-driven net
);

    // Internal signals
    wire [31:0] pc_out, pc_in, add_alu_out, add_pc_out;
    wire [31:0] instruction;
    wire [31:0] read_data1, read_data2, imm_out;
    wire [31:0] alu_input, write_data, mem_read_data;
    wire [31:0] alu_result;
    wire z_flag;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;
    
    // Control signals
    wire branch, memread, memtoreg, memwrite, alusrc, regwrite;
    wire [1:0] aluop;
    wire [3:0] alu_control;
    wire c_flag, n_flag, v_flag;
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

    // Instruction Memory
    instruction_memory imem (
        .reset(reset),
        .pc_out(pc_out),
        .instruction(instruction)
    );

    // Decode instruction
    assign opcode = instruction[6:0];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7]; 

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
        .instruction(instruction),
        .immout(imm_out)
    );

    // Adders
    add_pc pc_adder (
        .pc_out(pc_out),
        .add_pc_out(add_pc_out)
    );

    add branch_adder (
        .a(pc_out),
        .b(imm_out),
        .add_out(add_alu_out)
    );

    // Register File
    registers reg_file (
        .reset(reset),
        .clk(clk),
        .reg_write(regwrite),
        .read_reg1(rs1),
        .read_reg2(rs2),
        .write_reg(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ALU Input MUX
    mux mux_alu_in (
        .b(read_data2),
        .a(imm_out),
        .sel(alusrc),
        .mux_out(alu_input)
    );

    // ALU
    alu alu (
        .I1(read_data1),
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
        .aluop(aluop),
        .funct3(instruction[14:12]),
        .funct7(instruction[30]),
        .alu_ctr(alu_control)
    );

    // Data Memory
    data_mem data_mem (
        .reset(reset),
        .clk(clk),
        .address(alu_result),
        .write_data(read_data2),
        .memwrite(memwrite),
        .memread(memread),
        .read_data(mem_read_data)
    );

    // MUX for Memory to Register (MemtoReg)
    mux mux_data_mem (
        .b(alu_result),
        .a(mem_read_data),
        .sel(memtoreg),
        .mux_out(write_data)
    );

    wire c;
    assign c = z_flag && branch;

    mux mux_pc (
        .a(add_alu_out),
        .b(add_pc_out),
        .sel(c),
        .mux_out(pc_in) 
    );
    assign out = alu_result [3:0];

endmodule
