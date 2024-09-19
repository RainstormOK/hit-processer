module alu_me (
    input [5:0] op,
    input [5:0] alu_func,
    input STATE_EX,

    input [31:0] alu_dataA,
    input [31:0] alu_dataB,

    output reg [31:0] alu_result
);

initial begin
    alu_result = 32'd0;
end


parameter op_alu = 6'b000000;

parameter alu_add = 6'b100000;
parameter alu_sub = 6'b100010;
parameter alu_and = 6'b100100;
parameter alu_or  = 6'b100101;
parameter alu_xor = 6'b100110;
parameter alu_slt = 6'b101010;
parameter alu_mov = 6'b001010;
parameter alu_sll = 6'b000000;

always @ (*) begin
    if (STATE_EX) begin
        if (op == op_alu) begin
            case (alu_func)
                alu_add: alu_result <= alu_dataA + alu_dataB;
                alu_sub: alu_result <= alu_dataA - alu_dataB;
                alu_and: alu_result <= alu_dataA & alu_dataB;
                alu_or : alu_result <= alu_dataA | alu_dataB;
                alu_xor: alu_result <= alu_dataA ^ alu_dataB;
                alu_slt: alu_result <= (alu_dataA < alu_dataB) ? 32'b1 : 32'b0;
                alu_mov: alu_result <= alu_dataA;
                alu_sll: alu_result <= alu_dataB << alu_dataA;
            endcase
        end
        else begin
            alu_result <= alu_dataA + alu_dataB;
        end
    end
end

endmodule