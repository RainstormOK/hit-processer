module tb_ALU;

// Testbench signals
reg [31:0] A;
reg [31:0] B;
reg Cin;
reg [4:0] Card;
wire [31:0] F;
wire Cout;
wire Zero;

// Instantiate the ALU
ALU uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Card(Card),
    .F(F),
    .Cout(Cout),
    .Zero(Zero)
);

initial begin
    // Test case 1: F = A + B
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b00000;
    #10;
    $display("F = A + B: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 2: F = A + B + Cin
    A = 32'hFFFFFFFF;
    B = 32'h00000001;
    Cin = 1'b1;
    Card = 5'b00001;
    #10;
    $display("F = A + B + Cin: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 3: F = A - B
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b00010;
    #10;
    $display("F = A - B: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 4: F = A - B - Cin
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b1;
    Card = 5'b00011;
    #10;
    $display("F = A - B - Cin: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 5: F = B - A
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b00100;
    #10;
    $display("F = B - A: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 6: F = B - A - Cin
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b1;
    Card = 5'b00101;
    #10;
    $display("F = B - A - Cin: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 7: F = A
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b00110;
    #10;
    $display("F = A: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 8: F = B
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b00111;
    #10;
    $display("F = B: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 9: F = not A
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b01000;
    #10;
    $display("F = not A: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 10: F = not B
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b01001;
    #10;
    $display("F = not B: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 11: F = A or B
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b01010;
    #10;
    $display("F = A or B: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 12: F = A and B
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b01011;
    #10;
    $display("F = A and B: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);
    
    // Test case 13: F = A xnor B
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b01101;
    #10;
    $display("F = A xnor B: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 14: F = A xor B
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b01100;
    #10;
    $display("F = A xor B: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);
    // Test case 15: F = nand(A, B)
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b01110;
    #10;
    $display("F = nand(A, B): F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test case 16: F = 0
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 1'b0;
    Card = 5'b01111;
    #10;
    $display("F = 0: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // End simulation
    $stop;
end

endmodule
