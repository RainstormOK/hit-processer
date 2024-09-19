module cu_me (
    input STATE_ID,
    input [31:0] rs_data,
    input [31:0] pc,
    input [31:0] rt_data,
    input [4:0] rt,

    input [31:0] offset,
    input [31:0] sa,
    input [31:0] target,
    input [5:0] op,
    input [5:0] alu_func,

    output reg  branch_en,
    output reg  mem_wen,
    output reg  reg_wen,
    output reg lw_en,

    output reg [31:0] alu_dataA,
    output reg [31:0] alu_dataB
);

reg [31:0] cmp;

parameter op_alu = 6'b000000;
parameter op_sw = 6'b101011;
parameter op_lw = 6'b100011;
parameter op_ben = 6'b000101;
parameter op_j = 6'b000010;
parameter op_cmp = 6'b111110;
parameter op_bbt = 6'b111111;

parameter alu_mov = 6'b001010;
parameter alu_sll = 6'b000000;


always @ (*) begin
    if (STATE_ID) begin
        case(op)
            op_alu: begin
                branch_en <= 1'b0;
                mem_wen <= 1'b0;
                // reg_wen <= (alu_func == alu_mov && rt_data == 0) ? 1'b0 : 1'b1; // MOVZ
                if (alu_func == alu_mov) begin
                    if (rt_data != 0) begin
                        reg_wen <= 1'b0;
                    end
                end
                else begin
                    reg_wen <= 1'b1;
                end
                lw_en <= 1'b0;
                alu_dataA <= (alu_func == alu_sll) ? sa : rs_data;              // SLL
                alu_dataB <= rt_data;
            end
            op_sw: begin
                branch_en <= 1'b0;
                mem_wen <= 1'b1;
                reg_wen <= 1'b0;
                lw_en <= 1'b0;
                alu_dataA <= rs_data;
                alu_dataB <= offset;
            end
            op_lw: begin
                branch_en <= 1'b0;
                mem_wen <= 1'b0;
                reg_wen <= 1'b1;
                lw_en <= 1'b1;
                alu_dataA <= rs_data;
                alu_dataB <= offset;
            end
            op_ben: begin
                branch_en <= 1'b1;
                mem_wen <= 1'b0;
                reg_wen <= 1'b0;
                lw_en <= 1'b0;
                alu_dataA <= (rs_data != rt_data) ? offset << 2 : 0;
                alu_dataB <= pc + 4;
            end
            op_j: begin
                branch_en <= 1'b1;
                mem_wen <= 1'b0;
                reg_wen <= 1'b0;
                lw_en <= 1'b0;
                alu_dataA <= target;
                alu_dataB <= 0;
            end
            op_cmp: begin  
                branch_en <= 1'b0;
                mem_wen <= 1'b0;
                reg_wen <= 1'b1;
                lw_en <= 1'b0;
                alu_dataA <= cmp;
                alu_dataB <= 0;
            end
            op_bbt: begin
                branch_en <= 1'b1;
                mem_wen <= 1'b0;
                reg_wen <= 1'b0;
                lw_en <= 1'b0;
                alu_dataA <= (rs_data[rt]) ? offset << 2 : 0;
                alu_dataB <= pc + 4;
            end
            default: begin
                branch_en <= 1'b0;
                mem_wen <= 1'b0;
                reg_wen <= 1'b0;
                lw_en <= 1'b0;
                alu_dataA <= 1'b0;
                alu_dataB <= 1'b0;
            end
        endcase
    end
end

always @ (*) begin
    if (rs_data == rt_data) begin
        cmp[0] <= 1'b1;
    end
    else begin
        cmp[0] <= 1'b0;
    end

    if (rs_data < rt_data) begin
        cmp[1] <= 1'b1;
    end
    else begin
        cmp[1] <= 1'b0;
    end

    if ($unsigned(rs_data) < $unsigned(rt_data)) begin
        cmp[2] <= 1'b1;
    end
    else begin
        cmp[2] <= 1'b0;
    end

    if (rs_data <= rt_data) begin
        cmp[3] <= 1'b1;
    end
    else begin
        cmp[3] <= 1'b0;
    end

    if ($unsigned(rs_data) <= $unsigned(rt_data)) begin
        cmp[4] <= 1'b1;
    end
    else begin
        cmp[4] <= 1'b0;
    end

    cmp[9:5] <= ~cmp[4:0];
    cmp[31:10] <= 22'b0;
end

endmodule