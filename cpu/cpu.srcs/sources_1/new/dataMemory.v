module data_memory (
    input wire clk,
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire mem_write,
    output reg [31:0] read_data
);
    reg [31:0] memory [255:0];

    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[7:0]] <= write_data;
        end
    end

    always @(*) begin
        read_data = memory[address[7:0]];
    end
endmodule
