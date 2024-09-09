`timescale 1ns / 1ps

module cpu_tb;

    // Clock and reset
    reg clk;
    reg resetn;

    // Instantiate the CPU
    cpu uut (
        .clk(clk),
        .resetn(resetn)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100MHz clock, period 10ns

    // Initialize the instruction memory with a set of instructions
    // initial begin

    //     uut.rf.regs[0] = 32'd5;
    //     uut.rf.regs[1] = 32'd6;

    //     uut.inst_mem.mem[0] = 32'b000000_00000_00001_00010_00000_100000; // ADD
    //     uut.inst_mem.mem[1] = 32'b000000_00001_00000_00010_00000_100010; // SUB
    //     uut.inst_mem.mem[2] = 32'b000000_00000_00001_00010_00000_100100; // AND
    //     uut.inst_mem.mem[3] = 32'b000000_00000_00001_00010_00000_100101; // OR
    //     uut.inst_mem.mem[4] = 32'b000000_00000_00001_00010_00000_100110; // XOR
    //     uut.inst_mem.mem[5] = 32'b000000_00000_00001_00010_00000_101010; // SLT
    //     uut.inst_mem.mem[6] = 32'b000000_00000_00001_00010_00000_001010; // MOVZ 
    //     uut.inst_mem.mem[6] = 32'b000000_00000_00001_00010_00011_000000; // SLL 

    //     uut.inst_mem.mem[7] = 32'b101011_00000_00010_0000_0000_0000_0001; // SW
    //     uut.inst_mem.mem[8] = 32'b100011_00000_00000_0000_0000_0000_0001; // LW

    //     uut.inst_mem.mem[9] = 32'b000101_00000_00001_0000_0000_0000_0010; // BNE
    //     uut.inst_mem.mem[10] = 32'b000010_0000_0000_0000_0000_0000_0000_01; // J

    //     uut.inst_mem.mem[11] = 32'b000000_00000_00001_00010_00000_100000; // ADD
    //     uut.inst_mem.mem[12] = 32'b000000_00001_00000_00010_00000_100010; // SUB
    //     uut.inst_mem.mem[13] = 32'b000000_00000_00001_00010_00000_100100; // AND
    //     uut.inst_mem.mem[14] = 32'b000000_00000_00001_00010_00000_100101; // OR
    //     uut.inst_mem.mem[15] = 32'b000000_00000_00001_00010_00000_100110; // XOR
    //     uut.inst_mem.mem[16] = 32'b000000_00000_00001_00010_00000_101010; // SLT
    //     uut.inst_mem.mem[17] = 32'b000000_00000_00001_00010_00000_001010; // MOVZ 
    //     uut.inst_mem.mem[18] = 32'b000000_00000_00001_00010_00011_000000; // SLL 

    //     uut.inst_mem.mem[19] = 32'b101011_00000_00010_0000_0000_0000_0001; // SW
    //     uut.inst_mem.mem[20] = 32'b100011_00000_00000_0000_0000_0000_0001; // LW

    //     uut.inst_mem.mem[21] = 32'b000010_0000_0000_0000_0000_0000_0000_01; // J
    //     uut.inst_mem.mem[22] = 32'b000000_00001_00000_00010_00000_100010; // SUB
    //     uut.inst_mem.mem[23] = 32'b000000_00000_00001_00010_00000_100100; // AND
    //     uut.inst_mem.mem[24] = 32'b000000_00000_00001_00010_00000_100101; // OR
    //     uut.inst_mem.mem[25] = 32'b000000_00000_00001_00010_00000_100110; // XOR
    //     uut.inst_mem.mem[26] = 32'b000000_00000_00001_00010_00000_101010; // SLT
    //     uut.inst_mem.mem[27] = 32'b000000_00000_00001_00010_00000_001010; // MOVZ 
    // end

    initial begin
        uut.data_mem.memory[0] = 32'd0;
        uut.data_mem.memory[1] = 32'd10;
        uut.data_mem.memory[2] = 32'd9;
        uut.data_mem.memory[3] = 32'd0;
        uut.data_mem.memory[4] = 32'd0;

        uut.inst_mem.mem[0] = 32'b100011_00000_00001_0000_0000_0000_0100;   // LW $1, 4($0)
        uut.inst_mem.mem[1] = 32'b100011_00000_00010_0000_0000_0000_1000;   // LW $2, 8($0)
        uut.inst_mem.mem[2] = 32'b000000_00001_00010_00011_00000_100000;    // ADD $3, $1, $2
        uut.inst_mem.mem[3] = 32'b000000_00001_00010_00100_00000_100010;    // SUB $4, $1, $2
        uut.inst_mem.mem[4] = 32'b000000_00001_00010_00101_00000_100100;    // AND $5, $1, $2
        uut.inst_mem.mem[5] = 32'b000000_00001_00010_00110_00000_100101;    // OR $6, $1, $2
        uut.inst_mem.mem[6] = 32'b000000_00001_00010_00111_00000_100110;    // XOR $7, $1, $2
        uut.inst_mem.mem[7] = 32'b000000_00001_00010_01000_00000_101010;    // SLT $8, $1, $2
        uut.inst_mem.mem[8] = 32'b000000_00000_00001_01001_00010_000000;    // SLL $9, $1, 0x2
        uut.inst_mem.mem[9] = 32'b101011_00000_00001_0000_0000_0000_1000;    // SW $1, 8($0)
        uut.inst_mem.mem[10] = 32'b101011_00000_00010_0000_0000_0000_0100;    // SW $2, 4($0)
        uut.inst_mem.mem[11] = 32'b000101_00001_00010_0000_0000_0000_0100;    // BNE $1, $2, 0x4 // 52
        uut.inst_mem.mem[12] = 32'b101011_00000_00001_0000_0000_0000_0000;    // SW $1, 0($0)
        uut.inst_mem.mem[13] = 32'b000010_0000_0000_0000_0000_0000_0000_00;    // J 0
        uut.inst_mem.mem[14] = 32'b000010_0000_0000_0000_0000_0000_0100_00;    // J 0x10
        uut.inst_mem.mem[15] = 32'b101011_00000_00001_0000_0000_0000_0000;    // SW $1, 0($0)
        uut.inst_mem.mem[16] = 32'b100011_00000_00000_0000_0000_0000_0000;    // LW $0, 0($0)
        uut.inst_mem.mem[17] = 32'b000010_0000_0000_0000_0000_0000_0000_00;    // J 0
    end

    // initial begin
    //     uut.data_mem.memory[0] = 32'd0;
    //     uut.data_mem.memory[1] = 32'd1;
    //     uut.data_mem.memory[2] = 32'd2;
    //     uut.data_mem.memory[3] = 32'd3;
    //     uut.data_mem.memory[4] = 32'd4;
    //     uut.inst_mem.mem[0] = 32'b100011_00000_00001_0000_0000_0000_0100; // LW
    // end

    // Testbench initialization
    initial begin
        // Initialize signals
        clk = 0;
        resetn = 0;

        // Apply reset
        #1 resetn = 1;

        // Run for a specified time
        #1000;
        $finish;
    end

    // Monitor signals for debugging
    initial begin
            // $monitor("Time: %0t | PC: %d | Instr: %b | rs: %b | rt: %b | rd: %b | RegFile[0]: %d | RegFile[1]: %d | RegFile[2]: %d | ALU Result: %d | Mem[1] : %d", 
            //         $time, uut.pc, uut.instruction, uut.rs, uut.rt, uut.rd, uut.rf.regs[0], uut.rf.regs[1], uut.rf.regs[2], uut.alu_result, uut.data_mem.memory[1]);
        $monitor("PC: %d | Instr: %b | RegFile[1]: %d | RegFile[2]: %d | ALU Result: %d |Mem[0] : %d| Mem[1] : %d | Mem[2] : %d", 
        uut.pc, uut.instruction, uut.rf.regs[1], uut.rf.regs[2], uut.alu_result, uut.data_mem.memory[0], uut.data_mem.memory[1], uut.data_mem.memory[2]);
        $monitor("[3]: %d, [4]: %d, [5]: %d, [6]: %d, [7]: %d, [8]: %d, [9]: %d", uut.rf.regs[3], uut.rf.regs[4], uut.rf.regs[5], uut.rf.regs[6], uut.rf.regs[7], uut.rf.regs[8], uut.rf.regs[9]);
    
    end

endmodule
