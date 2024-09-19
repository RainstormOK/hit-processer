module regfile_me (
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] reg_wnum,

    input [31:0] write_data,
    input write_enable,

    output [31:0] rs_data,
    output [31:0] rt_data
);

reg [31:0] rf_mem [31:0];

initial begin
    rf_mem[0] = 32'b0;
    rf_mem[8] = 32'b0;
end

assign rs_data = rf_mem[rs];
assign rt_data = rf_mem[rt];

always @ (write_enable) begin
    if (write_enable && reg_wnum != 0) begin
        rf_mem[reg_wnum] <= write_data;
    end
end

endmodule