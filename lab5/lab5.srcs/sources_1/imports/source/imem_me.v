module instructionMemory_me (
    output inst_sram_en,
    output [31:0] inst_sram_addr,
    input [31:0] inst_sram_rdata,

    input STATE_IF,
    input resetn,

    input [31:0] pc_will,
    output [31:0] instruction,
    output reg [31:0] pc
);

assign inst_sram_en = 1'b1;
assign inst_sram_addr = pc_will;

assign instruction = inst_sram_rdata;

always @ (*) begin
    if (STATE_IF) begin
        pc <= pc_will;
    end
end

endmodule