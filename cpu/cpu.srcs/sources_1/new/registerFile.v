module reg_file (
    input wire clk,
    input wire [4:0] rs, rt, rd,
    input wire [31:0] wd,
    input wire reg_write,
    output wire [31:0] rs_data, rt_data
);
    reg [31:0] regs [31:0];

    assign rs_data = regs[rs];
    assign rt_data = regs[rt];

    always @(*) begin
        if (reg_write) begin
            regs[rd] <= wd;
        end
    end
endmodule
