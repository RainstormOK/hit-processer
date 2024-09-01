module regfile (
    input wire clk,           // 时钟信号
    input wire we,            // 写使能信号
    input wire [4:0] raddr1,  // 读地址1
    input wire [4:0] raddr2,  // 读地址2
    input wire [4:0] waddr,   // 写地址
    input wire [31:0] wdata,  // 写数据
    output reg [31:0] rdata1, // 读数据1
    output reg [31:0] rdata2  // 读数据2
);

    // 32个32位寄存器
    reg [31:0] regs[31:0];

    // 读操作
    always @(*) begin
        rdata1 = regs[raddr1];
        rdata2 = regs[raddr2];
    end

    // 写操作
    always @(posedge clk) begin
        if (we) begin
            regs[waddr] <= wdata;
        end
    end

endmodule
