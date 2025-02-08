module Add_PC_tb();
reg [31:0] PC_out;
wire [31:0] add_out;

Add_PC uut(.PC_out(PC_out), .add_out(add_out));

initial begin
PC_out = 32'h0; #10
PC_out = 32'h4; #10
PC_out = 32'h8; #10
PC_out = 32'hc; #10
$finish;
end
endmodule