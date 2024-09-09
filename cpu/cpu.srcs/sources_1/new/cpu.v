module cpu (
    input wire clk,          // clock, 100MHz
    input wire resetn,       // active low

    // debug
    output [31:0] debug_wb_pc,
    output debug_wb_rf_wen,
    output [4:0] debug_rf_addr,
    output [31:0] debug_wb_rf_wdata
);
    // Internal signals
    wire [31:0] instruction, instruction_reg;
    reg [31:0] pc_next;
    wire [31:0] pc;
    reg [31:0] alu_result;
    wire [31:0] mem_data;
    wire [31:0] rs_data, rt_data;
    wire [4:0] rs, rt, rd;
    wire reg_write, mem_write;
    wire [31:0] offset_ext, base_ext, sa_ext;
    wire [31:0] write_data, rd_or_rt;
    
    // Instantiate components
    program_counter pc_reg (
        .clk(clk),
        .reset(~resetn),
        .pc_in(pc_next),
        .pc_out(pc)
    );
    
    instruction_memory inst_mem (
        .address(pc / 4),
        .instruction(instruction)
    );
    
    reg_file rf (
        .clk(clk),
        .rs(rs),
        .rt(rt),
        .rd(rd_or_rt),    // should be alu_result
        .wd(write_data),
        .reg_write(reg_write),
        .rs_data(rs_data),
        .rt_data(rt_data)
    );
    
    data_memory data_mem (
        .clk(clk),
        .address(alu_result >> 2),
        .write_data(rt_data),
        .mem_write(mem_write),
        .read_data(mem_data)
    );
    
    instruction_register ir (
        .clk(clk),
        .instruction_in(instruction),
        .instruction_out(instruction_reg)
    );

    // Decode instruction
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign reg_write = (instruction[31:26] != 6'b101011
                        && instruction[31:26] != 6'b000101
                        && instruction[31:26] != 6'b000010) ? 1'b1 : 1'b0; 
    assign mem_write = (instruction[31:26] == 6'b101011) ? 1'b1 : 1'b0;
    assign write_data = (instruction[31:26] == 6'b100011) ? mem_data : alu_result;
    assign rd_or_rt = (instruction[31:26] == 6'b100011) ? rt : rd;
    
    // Immediate value
    assign offset_ext = {16'b0, instruction[15:0]}; // Sign-extended immediate
    assign base_ext = {27'b0, instruction[25:21]};
    assign sa_ext = {27'b0, instruction[10:6]};

    // debug assign
    assign debug_wb_pc = pc;
    assign debug_wb_rf_wen = reg_write;
    assign debug_wb_rf_addr = rd;
    assign debug_wb_rf_wdata = write_data;

    // ALU operation and branch logic
    always @(posedge clk or resetn) begin

        if (!resetn) begin
            pc_next <= 32'd0;
        end else begin
            case (instruction[31:26])
                6'b100011: begin // LW
                    alu_result <= (base_ext + offset_ext);
                    pc_next <= pc + 32'd4;
                end
                6'b101011: begin // SW
                    // Store word
                    alu_result <= (base_ext + offset_ext);
                    pc_next <= pc + 32'd4;
                end
                6'b000000: begin // R-type (ADD, SUB, etc.)
                    case (instruction[5:0])
                        6'b100000: alu_result <= rs_data + rt_data; // ADD
                        6'b100010: alu_result <= rs_data - rt_data; // SUB
                        6'b100100: alu_result <= rs_data & rt_data; // AND
                        6'b100101: alu_result <= rs_data | rt_data; // OR
                        6'b100110: alu_result <= rs_data ^ rt_data; // XOR
                        6'b101010: alu_result <= (rs_data < rt_data) ? 32'd1 : 32'd0; // SLT
                        6'b001010: if (rt_data == 32'd0) alu_result <= rs_data; // MOVZ
                        6'b000000: alu_result <= rt_data << sa_ext;     // SLL
                        default: alu_result <= 32'd0;
                    endcase
                    pc_next <= pc + 32'd4;
                end
                6'b000101: begin // BNE
                    pc_next <= (rs_data != rt_data) ? ((offset_ext << 2) + pc) : (pc + 32'd4);
                end
                6'b000010: begin // J
                    pc_next <= {pc[31:28], instruction[25:0], 2'b00};
                end
                default: begin
                    pc_next <= pc + 32'd4;
                end
            endcase
        end
    end
endmodule
