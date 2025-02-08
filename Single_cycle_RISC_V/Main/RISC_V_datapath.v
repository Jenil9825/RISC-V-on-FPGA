module RISC_V_datapath(
    input wire clk,
    input wire reset
);
    // Internal signals
    wire [31:0] PC_out, PC_in, add_out, add_alu_out;
    wire [31:0] instruction;
    wire [31:0] read_data1, read_data2, imm_out;
    wire [31:0] alu_in2, write_data, mem_read_data;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;

    // Control signals
    wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;
    wire [3:0] ALU_control;
    wire C_flag, N_flag, V_flag;

    // Program Counter (PC)
    PC pc (
        .clk(clk),
        .reset(reset),
        .PC_in(PC_in),
        .PC_out(PC_out)
    );

    // Instruction Memory
    instruction_memory imem (
        .PC_out(PC_out),
        .reset(reset),
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
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

    // Immediate Generator
    imm_gen imm_gen (
        .instruction(instruction),
        .immOut(imm_out)
    );

    // Adders
    Add_PC pc_adder (
        .PC_out(PC_out),
        .add_out(add_out)
    );

    Add_ALU branch_adder (
        .PC_out(PC_out),
        .imm_gen(imm_out),
        .add_alu_out(add_alu_out)
    );

    // Register File
    registers reg_file (
        .RegWrite(RegWrite),
        .read_reg1(rs1),
        .read_reg2(rs2),
        .write_reg(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ALU Input MUX
    mux_alu_input #(.W(32)) mux_alu_in (
        .read_data2(read_data2),
        .imm_data(imm_out),
        .sel(ALUSrc),
        .alu_input(alu_in2)
    );

    // ALU
    ALU #(.W(32)) alu (
        .I1(read_data1),
        .I2(alu_in2),
        .alu_ctr(ALU_control),
        .out(ALU_result),
        .N_flag(N_flag),
        .Z_flag(Zero_flag),
        .C_flag(C_flag),
        .V_flag(V_flag)
    );

    // ALU Control Unit
    ALU_Control alu_ctrl (
        .ALUOp(ALUOp),
        .funct3(instruction[14:12]),
        .funct7(instruction[30]),
        .alu_ctr(ALU_control)
    );

    // Data Memory
    data_memory data_mem (
        .address(ALU_result),
        .write_data(read_data2),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .read_data(mem_read_data)
    );

    // MUX for Memory to Register (MemtoReg)
    mux_data_mem #(.W(32)) mux_data_mem (
        .alu_result(ALU_result),
        .read_data(mem_read_data),
        .sel(MemtoReg),
        .write_data(write_data)
    );

    // MUX for PC input (Branch decision)
    mux_pc mux_pc (
        .add_alu_out(add_alu_out),
        .add_out(add_out),
        .Z_flag(Zero_flag),
        .branch(Branch),
        .PC_in(PC_in)
    );

endmodule