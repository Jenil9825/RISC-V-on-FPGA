`timescale 1ns / 1ps

module registers (
    input wire clk,
    input wire reset,
    input wire reg_write,
    input wire [4:0] read_reg1,
    input wire [4:0] read_reg2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    input wire [31:0] pc_out,
    input wire [1:0] pc_sel,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2,
    output reg [31:0] pc_out_reg
);

    reg [31:0] reg_file [0:31];

    assign read_data1 = reg_file[read_reg1];
    assign read_data2 = reg_file[read_reg2];

    integer i;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_file[0] <= 32'b0;
            reg_file[1] <= 32'h0000000C;
            reg_file[2] <= 32'h0000000D;
            pc_out_reg <= 32'b0;
            for (i = 3; i < 32; i = i + 1) begin
                reg_file[i] <= 32'b0;
            end
        end else if (reg_write && write_reg != 5'b00000) begin
            case (pc_sel)
                2'b01: begin // JAL
                    reg_file[write_reg] <= pc_out + 32'd4;
                    pc_out_reg <= pc_out + 32'd16;
                end
                2'b10: begin // JALR
                    reg_file[write_reg] <= pc_out + 32'd4;
                    pc_out_reg <= pc_out + 32'd16;
                end
                default: begin // Regular Register Write
                    reg_file[write_reg] <= write_data;
                    pc_out_reg <= 32'b0;
                end
            endcase
        end
    end
    
endmodule
