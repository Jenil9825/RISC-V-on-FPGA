`timescale 1ns / 1ps


module TOP_tb();
    reg clk_signal;
    reg reset;
    reg switch;
    wire [31:0] out_1;
    TOP uut (
        .clk_signal(clk_signal),
        .reset(reset),
        .out_1(out_1),
        .switch(switch)
    );

    initial begin
        clk_signal = 0;
        forever #5 clk_signal = ~clk_signal;
    end

    initial begin
   reset = 1;
   switch = 0;

    #50;
//    reset = 1;
//    #50;
//    reset = 0;
//    #50;
    reset = 0;
    #454;
    switch = 1;
    #1
    switch = 0;
    #69
    switch = 1;
    #1
    switch = 0;
    #600
        $finish;
end

endmodule
