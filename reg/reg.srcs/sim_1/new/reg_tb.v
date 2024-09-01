module tb_regfile;
    reg clk;           // 时钟信号
    reg we;            // 写使能信号
    reg [4:0] raddr1;  // 读地址1
    reg [4:0] raddr2;  // 读地址2
    reg [4:0] waddr;   // 写地址
    reg [31:0] wdata;  // 写数据
    wire [31:0] rdata1; // 读数据1
    wire [31:0] rdata2; // 读数据2

    // 实例化寄存器堆
    regfile uut (
        .clk(clk),
        .we(we),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .waddr(waddr),
        .wdata(wdata),
        .rdata1(rdata1),
        .rdata2(rdata2)
    );

    // 时钟生成
    always #5 clk = ~clk;

    // 初始化和测试
    initial begin
        // 初始化信号
        clk = 0;
        we = 0;
        raddr1 = 0;
        raddr2 = 0;
        waddr = 0;
        wdata = 0;

        // 写入数据到寄存器1
        #10;
        we = 1;
        waddr = 5'd1;
        wdata = 32'hDEADBEEF;
        #10;
        we = 0;

        // 写入数据到寄存器2
        #10;
        we = 1;
        waddr = 5'd2;
        wdata = 32'hCAFEBABE;
        #10;
        we = 0;

        // 同时读取寄存器1和寄存器2的值
        raddr1 = 5'd1;
        raddr2 = 5'd2;
        #10;

        // 输出结果
        $display("rdata1 = %h, expected = DEADBEEF", rdata1);
        $display("rdata2 = %h, expected = CAFEBABE", rdata2);

        // 写入数据到寄存器3
        we = 1;
        waddr = 5'd3;
        wdata = 32'hFACEFEED;
        #10;
        we = 0;

        // 同时读取寄存器2和寄存器3的值
        raddr1 = 5'd2;
        raddr2 = 5'd3;
        #10;

        // 输出结果
        $display("rdata1 = %h, expected = CAFEBABE", rdata1);
        $display("rdata2 = %h, expected = FACEFEED", rdata2);

        $finish;
    end

endmodule