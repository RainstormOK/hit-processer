module adder_32bit (
    input [31:0] A,    // 32-bit input A
    input [31:0] B,    // 32-bit input B
    input Cin,    // 1-bit carry input
    output [31:0] F, // 32-bit F output
    output Cout   // 1-bit carry output
);

assign {Cout, F} = A + B + Cin;

endmodule
