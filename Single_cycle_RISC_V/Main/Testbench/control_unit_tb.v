module control_unit_tb();

reg [6:0] opcode;
wire Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite;

control_unit uut (.opcode(opcode), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));

initial begin
opcode = 7'b0110011; #10
opcode = 7'b0000011; #10
opcode = 7'b0100011; #10
opcode = 7'b1100011; #10
$finish;

end
endmodule