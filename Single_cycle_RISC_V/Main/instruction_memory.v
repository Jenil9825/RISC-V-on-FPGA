module instruction_memory(
    input [31:0] PC_out,  // Address from the Program Counter (PC)
    input reset,
    output [31:0] instruction // 32-bit instruction output
);

    // Define a memory array to store instructions
    reg [31:0] memory [0:255];
    
    assign instruction = (!reset) ? memory[PC_out[31:2]] : 32'h00000000;

    initial begin
        // Initialize memory with instructions
        memory[0] = 32'h00000000;
        memory[1] = 32'h12345678;
        memory[2] = 32'h9abcdef0;
        memory[3] = 32'h11111111;
        // Add more instructions as needed
    end
    endmodule