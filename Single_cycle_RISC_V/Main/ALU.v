`define n 5
    
    module ALU #(parameter W=`n)(
        input [W-1:0] I1, I2,
        input [3:0] alu_ctr,
        output reg [W-1:0] out,
        output reg N_flag, Z_flag, C_flag, V_flag
    );
        always@(*)
        begin
        // Initialize flags to default values
            N_flag = 0;
            Z_flag = 0;
            C_flag = 0;
            V_flag = 0;
            
            case(alu_ctr)
                4'b0000: out = I1 & I2; // AND
                4'b0001: out = I1 | I2; // OR
                4'b0010: {C_flag, out} = I1 + I2; // ADD
                4'b0011: {C_flag, out} = I1 - I2; // SUB
                4'b0100: out = (I1 < I2) ? 1 : 0; // SLT
                4'b0101: out = I1 << I2[3:0]; // SLL(Shift amount limited to 4 bits)
                4'b0110: out = I1 >> I2[3:0]; // SRL(Shift amount limited to 4 bits)
                4'b0111: out = I1 ^ I2; // XOR
                4'b1000: out = ~(I1 | I2); // NOR
                4'b1001: out = ~(I1 & I2); // NAND
                default: out = {W{1'b0}}; // Default case for safe synthesis
            endcase
            
            N_flag = out[W-1];
            Z_flag = (out == 0) ? 1 : 0;
            V_flag = (alu_ctr == 4'b0010 || alu_ctr == 4'b0011) && (I1[W-1] == I2[W-1] && out[W-1] != I1[W-1]);
        end
    endmodule