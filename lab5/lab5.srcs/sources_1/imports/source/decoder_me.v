module decoder_me (
    input STATE_ID,
    input [31:0] instruction,
    input [31:0] pc,

    output reg [31:0] offset,
    output reg [31:0] sa,
    output reg [31:0] target,

    output reg [5:0] op,
    output reg [4:0] rs,
    output reg [4:0] rt,
    output reg [4:0] rd,
    output reg [5:0] alu_func
);

wire [31:0] npc;
assign npc = pc + 4;

always @ (STATE_ID) begin
    if (STATE_ID) begin
        op <= instruction[31:26];
        rs <= instruction[25:21];
        rt <= instruction[20:16];
        rd <= instruction[15:11];
        alu_func <= instruction[5:0];

        offset <= {{16{instruction[15]}}, instruction[15:0]};
        sa <= {27'b0, instruction[10:6]};
        target <= {npc[31:28], instruction[25:0], 2'b00};
    end
end

endmodule