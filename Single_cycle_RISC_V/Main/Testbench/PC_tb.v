module PC_tb();
reg clk, reset;
reg [31:0] PC_in;
wire [31:0] PC_out;

PC uut(.clk(clk), .reset(reset), .PC_in(PC_in), .PC_out(PC_out));

initial begin
clk=0;
forever #5 clk=~clk;
end

initial begin
        reset = 1;
        PC_in = 32'b0;

        #10 reset = 0;
        
        #10 PC_in = 32'h4;
        #10 PC_in = 32'h8;
        #10 PC_in = 32'hc;

        #10 reset = 1;
        #10 reset = 0;
        PC_in = 32'hf;

        #10 $finish;
    end
endmodule