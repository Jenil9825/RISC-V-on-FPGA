module imm_gen_tb();

    reg [31:0] instruction;
    
    wire [31:0] immOut;

    imm_gen uut (
        .instruction(instruction),
        .immOut(immOut)
    );

    // Testbench logic
    initial begin
        
        instruction = 32'b01111111111100000000001000000011; 
        #10;

        instruction = 32'b11111111111100000000001000000011; 
        #10;

        
        instruction = 32'b00000011101000010010000100100011; 
        #10;

        
        instruction = 32'b11111111111000001000000011100011; 
        #10;

        instruction = 32'b00000001001000110100000010110111; 
        #10;

        instruction = 32'b00000000111101000000000011101111; 
        #10;

        $finish;
    end
endmodule