module instruction_memory (
    input wire [31:0] address,
    output reg [31:0] instruction
);
    reg [31:0] mem [255:0];

    always @(*) begin
        instruction <= mem[address[7:0]];
    end

endmodule
