`timescale 1ns / 1ps


module datapath_tb();
    reg clk;
    reg reset;
    wire [31:0] out;
    datapath uut (
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    initial begin
        clk = 0;
        forever #0 clk = ~clk;
    end

    initial begin
   reset = 1;

    #50
    reset = 0;
    #1000;
        $finish;
end

endmodule
