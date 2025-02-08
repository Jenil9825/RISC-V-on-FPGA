module Add_PC(
    input [31:0] PC_out,
    output [31:0] add_out
    );
    
    assign add_out = PC_out + 4;
endmodule
