module mux_pc(
    input add_alu_out,
    input add_out,
    input Z_flag,
    input branch,
    output PC_in
    );
    assign PC_in = (Z_flag && branch) ? add_alu_out : add_out;
endmodule