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
    output reg [31:0] switch_pc,
//    input [31:0] pc_out_reg_EX_MEM,
    input [31:0] pc_out_reg,
    input branch,
    input [31:0] add_pc_out,
    output reg [31:0] pc_next
);
    reg [2:0] a;
//   assign pc_next = branch ? (pc_sel) ? (pc_current + imm_offset) : (add_pc_out) : add_pc_out;  

reg prev_clk;

always @(posedge clk or negedge clk) begin
    prev_clk <= clk; // Store previous clock state
end
always @(*) begin
        if(reset) begin a = 0; end
//    $display("Time: %0t | pc_out_reg=%h | branch=%b | pc_sel=%b | rs1_value=%h | imm_offset=%h", 
//              $time, pc_out_reg, branch, pc_sel, rs1_value, imm_offset);
    if((c == 1) && (!prev_clk && clk)) begin
        pc_next = switch_pc + 32'd4;
        switch_pc = switch_pc + 32'd4;

    end else if(switch) begin 
        pc_next = switch_pc;
    end else if(pc_out_reg != 32'd0) begin
        pc_next = pc_out_reg;
    end else if(branch) begin
        if(pc_sel == 2'b01) begin
            pc_next = pc_current + imm_offset;
        end 
        else if(pc_sel == 2'b10) begin
            pc_next = (rs1_value + imm_offset) & 32'hFFFFFFFC; 
//            $display("JALR Taken: pc_next = %h", pc_next);
        end
    end 
    else begin
        pc_next = add_pc_out;
        switch_pc <= 32'h3FC;

    end    
end

endmodule