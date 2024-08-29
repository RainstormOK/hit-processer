module adder_32bit (
    input [31:0] A,    // 32-bit input A
    input [31:0] B,    // 32-bit input B
    input carry_in,    // 1-bit carry input
    output [31:0] sum, // 32-bit sum output
    output carry_out   // 1-bit carry output
);

assign {carry_out, sum} = A + B + carry_in;

endmodule
