module registers_tb;

    // Inputs
    reg RegWrite;
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [31:0] write_data;

    // Outputs
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // Instantiate the registers module
    registers uut (
        .RegWrite(RegWrite),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Test procedure
    initial begin
        // Initialize inputs
        RegWrite = 0;
        read_reg1 = 5'b00000;
        read_reg2 = 5'b00001;
        write_reg = 5'b00000;
        write_data = 32'b0;

        // Wait for global reset
        #5;

        // Test 1: Write data to register 1
        write_reg = 5'b00001;       
        write_data = 32'h12345678;  
        RegWrite = 1;               
        #5;                         

        // Test 2: Read from register 1
        read_reg1 = 5'b00001;       
        read_reg2 = 5'b00000;      
        #5;                         

        // Test 3: Try to write to register 0 (should not work as it's reserved)
        write_reg = 5'b00000;       
        write_data = 32'hABCDEF01;  
        RegWrite = 1;               
        #5;                         

        // Test 4: Read from register 0 (should be 0)
        read_reg1 = 5'b00000;      
        #5;                         

        // Test 5: Disable write and check if data is not written
        RegWrite = 0;               
        write_reg = 5'b00001;       
        write_data = 32'hDEADBEEF;
        #5;                         

        // Test 6: Read from register 1 (should still be 0 if write was disabled)
        read_reg1 = 5'b00001;       
        #5;                        
        $finish;
    end

endmodule