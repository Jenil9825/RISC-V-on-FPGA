`timescale 1ns / 1ps


module TOP_tb();
    reg clk_signal;
    reg reset;
    wire [3:0] out_1;
    TOP uut (
        .clk_signal(clk_signal),
        .reset(reset),
        .out_1(out_1)
    );

    initial begin
        clk_signal = 0;
        forever #5 clk_signal = ~clk_signal;
    end
    
    initial begin
   reset = 1;

    #100;
//    reset = 1;
//    #50;
//    reset = 0;
//    #50;
    reset = 0;
    #1000;
        $finish;
end

endmodule
