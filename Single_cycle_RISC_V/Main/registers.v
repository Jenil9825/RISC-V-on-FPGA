module registers (
    input wire RegWrite,         
    input wire [4:0] read_reg1,  // Address of the first register to read
    input wire [4:0] read_reg2,  // Address of the second register to read
    input wire [4:0] write_reg,  // Address of the register to write
    input wire [31:0] write_data,// Data to be written into the register
    output reg [31:0] read_data1,// Data read from the first register
    output reg [31:0] read_data2 // Data read from the second register
);

    reg [31:0] register_file [31:0];    
    //Write Operation
    always @(*) begin
        if (RegWrite && write_reg != 5'b0) begin
            register_file[write_reg] = write_data; // Write data to the specified register
        end
    end
    //Read Operation
    always @(*) begin
        read_data1 = (read_reg1 != 5'b0) ? register_file[read_reg1] : 32'b0; // Read from register 1
        read_data2 = (read_reg2 != 5'b0) ? register_file[read_reg2] : 32'b0; // Read from register 2
    end

endmodule
