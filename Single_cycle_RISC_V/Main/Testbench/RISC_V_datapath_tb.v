module RISC_V_datapath_tb;

    reg clk;
    reg reset;
    wire [31:0] ALU_result;
    wire Zero_flag;

    RISC_V_datapath uut (
        .clk(clk),
        .reset(reset),
        .ALU_result(ALU_result),
        .Zero_flag(Zero_flag)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        reset = 0;

        reset = 1;
        #10;
        reset = 0;
        #10;

        #20;
        #20;
        #20;

        $finish;
    end

endmodule