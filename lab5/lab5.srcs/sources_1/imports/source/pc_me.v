module programCounter_me (
    input resetn,
    input [31:0] pc_next,
    input STATE_WB,
    output reg [31:0] pc_will
);

always @ (*) begin
    if (~resetn) begin
        pc_will <= 32'b0;
    end
    else begin
        if (STATE_WB) begin
            pc_will <= pc_next;
        end
    end
end

endmodule