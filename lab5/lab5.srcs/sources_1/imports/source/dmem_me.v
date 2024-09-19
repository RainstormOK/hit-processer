module dataMemory_me (
    output data_sram_en,       // 数据存储器端口读/写使能
    output [3:0]     data_sram_wen,      // 数据存储器写使能      
    output [31:0]    data_sram_addr,     // 数据存储器读/写地址
    output [31:0]    data_sram_wdata,    // 写入数据存储器的数据
    input [31:0]     data_sram_rdata,    // 数据存储器读出的数据

    input [31:0] alu_result,

    input mem_wen,
    input [31:0] rt_data,
    input STATE_MEM,

    output reg [31:0] dmem
);

assign data_sram_en = 1'b1;
assign data_sram_wen = {3'b0, mem_wen};
assign data_sram_addr = alu_result;
assign data_sram_wdata = rt_data;

always @ (*) begin
    if (STATE_MEM) begin
        dmem <= data_sram_rdata;
    end
end

endmodule