`timescale 1ns / 1ps

module tb_beat_shift;

// Inputs
reg clk;
reg rst;

// Outputs
wire [3:0] T;

// Instantiate the Unit Under Test (UUT)
beat_shift uut (
    .clk(clk),
    .rst(rst),
    .T(T)
);

// Clock generation
always #5 clk = ~clk;  // Generate a clock with a period of 10ns

initial begin
    // Initialize Inputs
    clk = 0;
    rst = 0;

    // Apply reset
    rst = 1;
    #10;  // Wait for 10 ns
    rst = 0;
    
    // Test for several clock cycles
    #50;  // Run for 50 ns with no reset

    // Apply reset again
    rst = 1;
    #10;  // Wait for 10 ns
    rst = 0;
    
    // Continue simulation
    #50;  // Run for 50 ns more

    // End of simulation
    $finish;
end

initial begin
    $monitor("At time %t: T = %b, rst = %b", $time, T, rst);
end

endmodule
