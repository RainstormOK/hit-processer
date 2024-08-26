`timescale 1ns / 1ps

module tb_mux221;

// Inputs
reg [1:0] d0;
reg [1:0] d1;
reg select;

// Outputs
wire [1:0] out;

// Instantiate the Unit Under Test (UUT)
mux221 uut (
    .d0(d0),
    .d1(d1),
    .select(select),
    .out(out)
);

initial begin
    // Initialize Inputs
    d0 = 2'b00;
    d1 = 2'b00;
    select = 0;

    // Wait for global reset to finish
    #100;

    // Test Case 1: select = 0, expect out = d0
    d0 = 2'b01;
    d1 = 2'b10;
    select = 0;
    #10;  // Wait for 10 ns
    $display("Test Case 1: d0 = %b, d1 = %b, select = %b, out = %b", d0, d1, select, out);

    // Test Case 2: select = 1, expect out = d1
    select = 1;
    #10;  // Wait for 10 ns
    $display("Test Case 2: d0 = %b, d1 = %b, select = %b, out = %b", d0, d1, select, out);

    // Test Case 3: d0 = 11, d1 = 00, select = 0, expect out = d0
    d0 = 2'b11;
    d1 = 2'b00;
    select = 0;
    #10;  // Wait for 10 ns
    $display("Test Case 3: d0 = %b, d1 = %b, select = %b, out = %b", d0, d1, select, out);

    // Test Case 4: d0 = 11, d1 = 00, select = 1, expect out = d1
    select = 1;
    #10;  // Wait for 10 ns
    $display("Test Case 4: d0 = %b, d1 = %b, select = %b, out = %b", d0, d1, select, out);

    // End of simulation
    $finish;
end

endmodule