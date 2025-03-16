`timescale 1ns / 1ps

module pc_mux(
    input [31:0] pc_current,
    input [31:0] imm_offset,
    input [31:0] rs1_value,
    input pc_sel,
//    input [31:0] pc_out_reg_EX_MEM,
    input [31:0] pc_out_reg,
    input branch,
    input [31:0] add_pc_out,
    output reg [31:0] pc_next
);
//   assign pc_next = branch ? (pc_sel) ? (pc_current + imm_offset) : (add_pc_out) : add_pc_out;  
    always @(*) begin
    if(pc_out_reg != 32'd0) begin
        pc_next <= pc_out_reg;
    end else if(branch) begin
                 if(pc_sel == 2'b01) begin
                     pc_next <= pc_current + imm_offset;
                 end else if(pc_sel == 2'b10) begin
                     pc_next <= (rs1_value + imm_offset) & ~1;
                 end
    end else begin
    pc_next <= add_pc_out;
    end    
    end
endmodule

