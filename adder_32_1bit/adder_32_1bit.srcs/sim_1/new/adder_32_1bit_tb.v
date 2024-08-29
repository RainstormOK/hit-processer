module tb_adder_32bit;

// Testbench signals
reg [31:0] A;
reg [31:0] B;
reg Cin;
wire [31:0] F;
wire Cout;

// Instantiate the 32-bit adder
adder_32bit uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .F(F),
    .Cout(Cout)
);

initial begin
    // Test case 1
    A = 32'h00000001;
    B = 32'h00000001;
    Cin = 1'b0;
    #10;  // Wait for 10 time units
    $display("Test Case 1: A = %h, B = %h, Cin = %b, F = %h, Cout = %b", A, B, Cin, F, Cout);

    // Test case 2
    A = 32'hFFFFFFFF;
    B = 32'h00000001;
    Cin = 1'b0;
    #10;
    $display("Test Case 2: A = %h, B = %h, Cin = %b, F = %h, Cout = %b", A, B, Cin, F, Cout);

    // Test case 3
    A = 32'hFFFFFFFF;
    B = 32'hFFFFFFFF;
    Cin = 1'b1;
    #10;
    $display("Test Case 3: A = %h, B = %h, Cin = %b, F = %h, Cout = %b", A, B, Cin, F, Cout);

    // End simulation
    $stop;
end

endmodule
