module cpu (

    input clk,
    input resetn,

    output          inst_sram_en,       // 指令存储器读使能
    output[31:0]    inst_sram_addr,     // 指令存储器读地址
    input[31:0]     inst_sram_rdata,    // 指令存储器读出的数据

    output          data_sram_en,       // 数据存储器端口读/写使�??
    output[3:0]     data_sram_wen,      // 数据存储器写使能      
    output[31:0]    data_sram_addr,     // 数据存储器读/写地�??
    output[31:0]    data_sram_wdata,    // 写入数据存储器的数据
    input[31:0]     data_sram_rdata,    // 数据存储器读出的数据

    // 供自动测试环境进行CPU正确性检�??
    output[31:0]    debug_wb_pc,        // 当前正在执行指令的PC
    output          debug_wb_rf_wen,    // 当前通用寄存器组的写使能信号
    output[4:0]     debug_wb_rf_wnum,   // 当前通用寄存器组写回的寄存器编号
    output[31:0]    debug_wb_rf_wdata   // 当前指令�??要写回的数据
);

initial begin
    $monitor("%h: %h, %h, %h", pc, alu_dataA, alu_dataB, alu_result);
end


wire [31:0] alu_dataA;
wire [31:0] alu_dataB;
wire [5:0] alu_func;
wire [31:0] alu_result;
wire branch_en;
wire [31:0] dmem;

wire [31:0] instruction; 
wire lw_en;
wire mem_wen;
wire [31:0] offset;
wire [5:0] op;
wire [31:0] pc;
wire [31:0] pc_add_4;
wire [31:0] pc_next;
wire [31:0] pc_will;
wire reg_wen;
wire [4:0] reg_wnum;
wire [4:0] rs;
wire [31:0] rs_data;
wire [4:0] rt;
wire [31:0] rt_data;
wire [4:0] rd;
wire STATE_IF;
wire STATE_ID;
wire STATE_EX;
wire STATE_MEM;
wire STATE_WB;
wire [31:0] sa;
wire [31:0] target;
wire write_enable;
wire [31:0] write_data;

stateControl_me state_control_me (
    .clk(clk),
    .resetn(resetn),
    .STATE_IF(STATE_IF),
    .STATE_ID(STATE_ID),
    .STATE_EX(STATE_EX),
    .STATE_MEM(STATE_MEM),
    .STATE_WB(STATE_WB)
);

assign pc_next = (branch_en) ? alu_result : pc_add_4;
assign pc_add_4 = pc + 4;

programCounter_me PC_me (
    .pc_next(pc_next),
    .resetn(resetn),
    .STATE_WB(STATE_WB),
    .pc_will(pc_will)
);

instructionMemory_me IMEM_me (
    .pc_will(pc_will),
    .STATE_IF(STATE_IF),
    .resetn(resetn),
    .instruction(instruction),
    .pc(pc),
    .inst_sram_en(inst_sram_en),
    .inst_sram_addr(inst_sram_addr),
    .inst_sram_rdata(inst_sram_rdata)
);

decoder_me Decode_me (
    .STATE_ID(STATE_ID),
    .instruction(instruction),
    .pc(pc),
    .offset(offset),
    .sa(sa),
    .target(target),
    .alu_func(alu_func),
    .op(op),
    .rs(rs),
    .rt(rt),
    .rd(rd)
);

cu_me CU_me (
    .STATE_ID(STATE_ID),
    .rt(rt),
    .rt_data(rt_data),
    .pc(pc),
    .rs_data(rs_data),
    .offset(offset),
    .sa(sa),
    .target(target),
    .op(op),
    .alu_func(alu_func),
    .branch_en(branch_en),
    .mem_wen(mem_wen),
    .reg_wen(reg_wen),
    .lw_en(lw_en),
    .alu_dataA(alu_dataA),
    .alu_dataB(alu_dataB)
);

alu_me ALU_me (
    .alu_dataA(alu_dataA),
    .alu_dataB(alu_dataB),
    .op(op),
    .alu_func(alu_func),
    .STATE_EX(STATE_EX),
    .alu_result(alu_result)
);

// wire [31:0] alu_result_copy;
// assign alu_result_copy = alu_result;

dataMemory_me DMEM_me (
    // .alu_result(alu_result_copy),
    .alu_result(alu_result),
    .mem_wen(mem_wen),
    .rt_data(rt_data),
    .STATE_MEM(STATE_MEM),
    .dmem(dmem),
    .data_sram_en(data_sram_en),
    .data_sram_addr(data_sram_addr),
    .data_sram_rdata(data_sram_rdata),
    .data_sram_wdata(data_sram_wdata),
    .data_sram_wen(data_sram_wen)
);

regfile_me REG_me (
    .rs_data(rs_data),
    .rt_data(rt_data),
    .rs(rs),
    .rt(rt),
    .reg_wnum(reg_wnum),
    .write_enable(write_enable),
    .write_data(write_data)
);

assign write_enable = (reg_wen && STATE_WB) && (reg_wnum != 0);

assign write_data = (lw_en) ? dmem : alu_result; 

assign reg_wnum = (lw_en) ? rt : rd;

assign debug_wb_pc = pc;
assign debug_wb_rf_wen = write_enable;
assign debug_wb_rf_wnum = reg_wnum;
assign debug_wb_rf_wdata = write_data;


endmodule