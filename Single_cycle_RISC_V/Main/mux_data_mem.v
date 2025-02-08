module mux_data_mem #(parameter W=32)(
    input wire [W-1:0] alu_result,  
    input wire [W-1:0] read_data,   
    input wire sel,                 
    output wire [W-1:0] write_data  
);

    assign write_data = (sel == 1'b0) ? alu_result : read_data; 
endmodule
