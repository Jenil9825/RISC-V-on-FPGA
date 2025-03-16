`timescale 1ns / 1ps

module alu(
    input [31:0] I1,
    input [31:0] I2,
    input [3:0] alu_ctr,
    output reg [31:0] alu_out,
    output reg n_flag,
    output reg z_flag,
    output reg c_flag,
    output reg v_flag,
    output reg [1:0] pc_sel
);
    
    always @(*) begin
        n_flag = 1'b0;
        z_flag = 1'b0;
        c_flag = 1'b0;
        v_flag = 1'b0;
        alu_out = 32'b0;
        pc_sel = 1'b0;
        case (alu_ctr)
            4'b0000: alu_out = I1 & I2; // AND
            4'b0001: alu_out = I1 | I2; // OR
            4'b0010: begin // ADD
                {c_flag, alu_out} = {1'b0, I1} + {1'b0, I2};
                v_flag = (I1[31] == I2[31]) && (alu_out[31] != I1[31]);
            end
            4'b0011: begin // SUB
                {c_flag, alu_out} = {1'b0, I1} - {1'b0, I2};
                v_flag = (I1[31] != I2[31]) && (alu_out[31] != I1[31]);
            end
            4'b0100: alu_out = (I1 < I2) ? 32'b1 : 32'b0; // SLT
            4'b0101: alu_out = I1 << I2; // SLL
            4'b0110: alu_out = I1 >> I2; // SRL
            4'b0111: alu_out = I1 ^ I2; // XOR
            4'b1000: alu_out = ~(I1 | I2); // NOR
            4'b1001: alu_out = ~(I1 & I2); // NAND

            // Handle JAL (Jump and Link) → PC + immediate
            4'b1010: begin 
                    alu_out = I1 + I2;
                    pc_sel = 2'b01;
                    end 

            // Handle JALR (Jump and Link Register) → (rs1 + immediate) & ~1
            4'b1011: begin 
                    alu_out = (I1 + I2) & ~32'b1;
                    pc_sel = 2'b10;
                    end

            default: alu_out = 32'b0;
        endcase

        // Set flags
        n_flag = alu_out[31]; 
        z_flag = (alu_out == 32'b0) ? 1'b1 : 1'b0;
    end

endmodule
