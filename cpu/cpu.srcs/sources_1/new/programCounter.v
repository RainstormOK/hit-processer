module program_counter (
    input wire clk,
    input wire reset,  // active-low reset input
    input wire [31:0] pc_in,
    output reg [31:0] pc_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 32'd0;
        end else begin
            pc_out <= pc_in;
        end
    end
endmodule
