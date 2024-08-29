module tb_adder_32bit;

// Testbench signals
reg [31:0] A;
reg [31:0] B;
reg carry_in;
wire [31:0] sum;
wire carry_out;

// Instantiate the 32-bit adder
adder_32bit uut (
    .A(A),
    .B(B),
    .carry_in(carry_in),
    .sum(sum),
    .carry_out(carry_out)
);

initial begin
    // Test case 1
    A = 32'h00000001;
    B = 32'h00000001;
    carry_in = 1'b0;
    #10;  // Wait for 10 time units
    $display("Test Case 1: A = %h, B = %h, carry_in = %b, sum = %h, carry_out = %b", A, B, carry_in, sum, carry_out);

    // Test case 2
    A = 32'hFFFFFFFF;
    B = 32'h00000001;
    carry_in = 1'b0;
    #10;
    $display("Test Case 2: A = %h, B = %h, carry_in = %b, sum = %h, carry_out = %b", A, B, carry_in, sum, carry_out);

    // Test case 3
    A = 32'hFFFFFFFF;
    B = 32'hFFFFFFFF;
    carry_in = 1'b1;
    #10;
    $display("Test Case 3: A = %h, B = %h, carry_in = %b, sum = %h, carry_out = %b", A, B, carry_in, sum, carry_out);

    // End simulation
    $stop;
end

endmodule
