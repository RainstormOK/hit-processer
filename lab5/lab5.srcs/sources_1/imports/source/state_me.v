module stateControl_me (
    input clk,
    input resetn,

    output STATE_IF,
    output STATE_ID,
    output STATE_EX,
    output STATE_MEM,
    output wire STATE_WB
);

reg [4:0] state, next_state;

parameter SIF = 5'b00001;
parameter SID = 5'b00010;
parameter SEX = 5'b00100;
parameter SME = 5'b01000;
parameter SWB = 5'b10000;

assign STATE_IF  = state[0];
assign STATE_ID  = state[1];
assign STATE_EX  = state[2];
assign STATE_MEM = state[3];
assign STATE_WB  = state[4];

always @ (posedge clk) begin
    if (~resetn) begin
        state <= SIF;
        next_state <= SID;
    end
    else begin
        state <= next_state;
        case (next_state) 
            SIF: next_state <= SID;
            SID: next_state <= SEX;
            SEX: next_state <= SME;
            SME: next_state <= SWB;
            SWB: next_state <= SIF;
        endcase
    end
end

endmodule

// module stateControl_me (
//     input clk,
//     input resetn,

//     output STATE_IF,
//     output STATE_ID,
//     output STATE_EX,
//     output STATE_MEM,
//     output STATE_WB
// );

// reg [4:0] state, next_state;

// parameter SIF  = 6'b000001;
// parameter SID  = 6'b000010;
// parameter SEX  = 6'b000100;
// parameter SMEP = 6'b001000;
// parameter SME  = 6'b010000;
// parameter SWB  = 6'b100000;

// assign STATE_IF  = state[0];
// assign STATE_ID  = state[1];
// assign STATE_EX  = state[2];
// assign STATE_MEM = state[4] | state[3];
// assign STATE_WB  = state[5];

// always @ (posedge clk) begin
//     if (!resetn) begin
//         state <= SIF;
//         next_state <= SID;
//     end
//     else begin
//         state <= next_state;
//         case (next_state) 
//             SIF: next_state <= SID;
//             SID: next_state <= SEX;
//             SEX: next_state <= SMEP;
//             SMEP: next_state <= SME;
//             SME: next_state <= SWB;
//             SWB: next_state <= SIF;
//         endcase
//     end
// end

// endmodule