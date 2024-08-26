module beat_shift (
    input clk,          // 1-bit clock signal 
    input rst,          // 1-bit reset signal 
    output reg [3:0] T  // 4-bit output 
);

always @(posedge clk) begin     // if positive edge of clock
    if (rst) begin              // if reset is 1
        T <= 4'b1000;   
    end else begin              // otherwise, make a right shift
        T <= {T[0], T[3:1]};    // and put the right bit onto left
    end
end

endmodule
