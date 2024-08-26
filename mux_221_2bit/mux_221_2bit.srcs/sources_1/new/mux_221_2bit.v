module mux221 (
    input [1:0] d0,     // 2-bit input data 0
    input [1:0] d1,     // 2-bit input data 1
    input select,       // 1-bit select signal
    output [1:0] out    // 2-bit output
);

assign out = (select) ? d1 : d0;

endmodule