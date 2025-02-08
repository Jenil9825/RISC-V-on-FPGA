module data_memory (
    input wire MemWrite,               
    input wire MemRead,                
    input wire [31:0] address,         
    input wire [31:0] write_data,      
    output reg [31:0] read_data        
);

    
    reg [31:0] memory [0:1023];
    
    // Memory read operation
    always @(*) begin
        if (MemRead)
            read_data = memory[address[11:2]];
        else
            read_data = 32'b0;
    end
    
    // Memory write operation
    always @(*) begin
        if (MemWrite)
            memory[address[11:2]] = write_data;
    end

endmodule