module ALU_Control_tb;

    reg [1:0] ALUOp;
    reg [2:0] funct3;
    reg funct7;
    wire [3:0] alu_ctr;

    ALU_Control uut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctr(alu_ctr)
    );

    initial begin
        ALUOp = 2'b00; funct3 = 3'b000; funct7 = 1'b0;
        #10;

        ALUOp = 2'b01; funct3 = 3'b000; funct7 = 1'b0;
        #10;

        ALUOp = 2'b01; funct3 = 3'b001; funct7 = 1'b0;
        #10;

        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 1'b0;
        #10;

        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 1'b1;
        #10;

        ALUOp = 2'b10; funct3 = 3'b111; funct7 = 1'b0;
        #10;

        ALUOp = 2'b10; funct3 = 3'b110; funct7 = 1'b0;
        #10;

        ALUOp = 2'b10; funct3 = 3'b100; funct7 = 1'b0;
        #10;

        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 1'b0;
        #10;

        $finish;
    end

endmodule
