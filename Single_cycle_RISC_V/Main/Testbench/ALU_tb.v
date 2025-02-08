module ALU_tb;

    // Parameters
    parameter W = 5;

    // Inputs
    reg [W-1:0] I1;
    reg [W-1:0] I2;
    reg [3:0] alu_ctr;

    // Outputs
    wire [W-1:0] out;
    wire N_flag, Z_flag, C_flag, V_flag;

    // Instantiate the ALU module
    ALU #(W) uut (
        .I1(I1),
        .I2(I2),
        .alu_ctr(alu_ctr),
        .out(out),
        .N_flag(N_flag),
        .Z_flag(Z_flag),
        .C_flag(C_flag),
        .V_flag(V_flag)
    );

    // Testbench logic
    initial begin
        // Test case 1: AND operation
        I1 = 5'b10101; I2 = 5'b11011; alu_ctr = 4'b0000;
        #10;

        // Test case 2: OR operation
        I1 = 5'b10101; I2 = 5'b11011; alu_ctr = 4'b0001;
        #10;

        // Test case 3: ADD operation with no overflow
        I1 = 5'b00101; I2 = 5'b00011; alu_ctr = 4'b0010;
        #10;

        // Test case 4: ADD operation with overflow
        I1 = 5'b01111; I2 = 5'b01111; alu_ctr = 4'b0010;
        #10;

        // Test case 5: SUB operation with no overflow
        I1 = 5'b01010; I2 = 5'b00011; alu_ctr = 4'b0011;
        #10;

        // Test case 6: SUB operation with overflow
        I1 = 5'b10000; I2 = 5'b00001; alu_ctr = 4'b0011;
        #10;

        // Test case 7: SLT operation
        I1 = 5'b00011; I2 = 5'b00100; alu_ctr = 4'b0100;
        #10;

        // Test case 8: SLL operation
        I1 = 5'b00011; I2 = 5'b00010; alu_ctr = 4'b0101;
        #10;

        // Test case 9: SRL operation
        I1 = 5'b10000; I2 = 5'b00010; alu_ctr = 4'b0110;
        #10;

        // Test case 10: XOR operation
        I1 = 5'b10101; I2 = 5'b11011; alu_ctr = 4'b0111;
        #10;

        // Test case 11: NOR operation
        I1 = 5'b10101; I2 = 5'b11011; alu_ctr = 4'b1000;
        #10;

        // Test case 12: NAND operation
        I1 = 5'b10101; I2 = 5'b11011; alu_ctr = 4'b1001;
        #10;

        // End simulation
        $finish;
    end

endmodule