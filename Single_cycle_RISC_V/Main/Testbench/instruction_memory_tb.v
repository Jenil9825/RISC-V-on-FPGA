module instruction_memory_tb();
reg [31:0] PC_out;
reg reset;
wire [31:0] instruction;

instruction_memory uut (.PC_out(PC_out), .reset(reset), .instruction(instruction));

initial begin
        PC_out = 0; 
        reset = 1;
        
        #10;
        reset = 0;

        // Test Address 0
        PC_out = 32'h00000000; 
        #10;
        // Test Address 4
        PC_out = 32'h00000004; 
        #10;

        // Test an uninitialized address
        PC_out = 32'h00000008;
        #10;

        reset = 1;
        #10;

        // End simulation
        $finish;
end
endmodule