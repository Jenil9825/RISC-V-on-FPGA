`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2025 16:36:52
// Design Name: 
// Module Name: clock_slow
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_slow(
     input wire clk, // 50 MHz clock input
     input wire reset,        // Active high reset
     output reg clock        // Toggling output signal
);
    
    reg [26:0] counter;  
      // 26-bit counter to count up to 50M
    initial begin
    counter <= 0;
    clock <= 0;
    end
    
    always @(posedge clk) begin
    
        if (reset) begin
            counter <= 0;
            clock <= 0;
        end else 
        if (counter == 27'd0) begin
            counter <= 0;
            clock <= ~clock;
        end else begin
            counter <= counter + 1;
        end
    end
//            if (counter == 27'd75000000) begin
//            counter <= 0;
//            clock <= ~clock;
//        end else begin
//            counter <= counter + 1;
//        end
//    end

endmodule
