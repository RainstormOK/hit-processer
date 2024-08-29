module ALU (
    input [31:0] A,       // 32-bit input A
    input [31:0] B,       // 32-bit input B
    input Cin,            // Carry-in input
    input [4:0] Card,     // 5-bit operation code
    output reg [31:0] F,  // 32-bit result output
    output reg Cout,      // Carry-out output
    output reg Zero       // Zero flag output
);

always @(*) begin
    case (Card)
        5'b00000: {Cout, F} = A + B;             // F = A + B
        5'b00001: {Cout, F} = A + B + Cin;       // F = A + B + Cin
        5'b00010: {Cout, F} = A - B;             // F = A - B
        5'b00011: {Cout, F} = A - B - Cin;       // F = A - B - Cin
        5'b00100: {Cout, F} = B - A;             // F = B - A
        5'b00101: {Cout, F} = B - A - Cin;       // F = B - A - Cin
        5'b00110: F = A;                         // F = A
        5'b00111: F = B;                         // F = B
        5'b01000: F = ~A;                        // F = not A
        5'b01001: F = ~B;                        // F = not B
        5'b01010: F = A | B;                     // F = A or B
        5'b01011: F = A & B;                     // F = A and B
        5'b01100: F = A ~^ B;                    // F = A xnor B
        5'b01101: F = A ^ B;                     // F = A xor B
        5'b01110: F = ~(A & B);                  // F = nand(A, B)
        5'b01111: F = 32'b0;                     // F = 0
        default: {Cout, F} = 33'b0;              // Default case (invalid Card)
    endcase
    
    // Zero flag
    Zero = (F == 32'b0) ? 1'b1 : 1'b0;
end

endmodule
