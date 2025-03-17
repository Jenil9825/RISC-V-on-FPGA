`timescale 1ns / 1ps


module TOP(
    input reset, 
    input clk_signal,  // 50 MHz input clock
    input switch,
    output [31:0] out_1
   
);
    wire clock;
   // assign clk1 = clk;

    // Instantiate clock divider
    clock_slow ck(.reset(reset),.clk(clk_signal), .clock(clock));

    // Instantiate main module with toggled clock
    datapath m1(.clk(clock) ,.reset(reset) ,.out(out_1), .switch(switch));
endmodule
