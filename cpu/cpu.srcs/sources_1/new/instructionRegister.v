module instruction_register (
    input wire clk,
    input wire [31:0] instruction_in,
    output reg [31:0] instruction_out
);
    always @(*) begin
        instruction_out <= instruction_in;
    end
endmodule
