`timescale 1ns / 1ps

module pc_mux(
    input clk,
    input reset,
    input [31:0] pc_current,
    input [31:0] imm_offset,
    input [4:0] rs1_value,
    input [1:0] pc_sel,
    input switch,
    input c,
    input [31:0] pc_out_reg,
    input branch,
    input [31:0] add_pc_out,
    output reg [31:0] switch_pc,
    output reg [31:0] pc_next
);

    always @(*) begin
    if((c == 1)) begin
        pc_next = switch_pc + 32'd4;
        switch_pc = switch_pc + 32'd4;
    end else if(switch) begin 
        pc_next = switch_pc;
    end else if(pc_out_reg != 32'b0) begin
        pc_next = pc_out_reg;
    end else if(branch) begin
        if(pc_sel == 2'b01) begin
            pc_next = pc_current + imm_offset;
        end 
        else if(pc_sel == 2'b10) begin
            pc_next = (rs1_value + imm_offset) & 32'hFFFFFFFC; 
        end
    end 
    else begin
        pc_next = add_pc_out;
        switch_pc <= 32'h3FC;

    end    
end

endmodule
