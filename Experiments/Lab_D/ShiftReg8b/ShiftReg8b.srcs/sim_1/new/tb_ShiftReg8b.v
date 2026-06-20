`timescale 1ns / 1ps

module tb_ShiftReg8b;

    reg clk;
    reg shiftn_loadp;
    reg shift_in;
    reg [7:0] par_in;
    wire [7:0] Q;

    // Instantiate the Unit Under Test (UUT)
    ShiftReg8b uut (
        .clk(clk),
        .shiftn_loadp(shiftn_loadp),
        .shift_in(shift_in),
        .par_in(par_in),
        .Q(Q)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        shiftn_loadp = 1;       // Start with load mode to set an initial value
        shift_in = 0;
        par_in = 8'b10110011;   // arbitrary initial pattern

        // Parallel load
        #10;                    // at first rising edge, load par_in (10110011)
        $display("After load: Q = %b", Q);

        // Switch to shift mode and shift in a '1'
        shiftn_loadp = 0;
        shift_in = 1;
        #10;                    // shift right, LSB lost, MSB becomes 1 -> Q = 1_1011001
        $display("Shift 1: Q = %b", Q);

        // Shift in a '0'
        shift_in = 0;
        #10;                    // Q = 0_1101100
        $display("Shift 2: Q = %b", Q);

        // Shift in a '1'
        shift_in = 1;
        #10;                    // Q = 1_0110110
        $display("Shift 3: Q = %b", Q);

        // Load a new value
        shiftn_loadp = 1;
        par_in = 8'b00001111;
        #10;                    // Q should become 00001111
        $display("After reload: Q = %b", Q);

        // Switch back to shift, shift in '0' twice
        shiftn_loadp = 0;
        shift_in = 0;
        #10;                    // Q = 0_0000111
        $display("Shift 4: Q = %b", Q);
        #10;                    // Q = 0_0000011
        $display("Shift 5: Q = %b", Q);

        $finish;
    end

    // Monitor changes
    always @(posedge clk) begin
        #1; // small delay to capture stable outputs
        $display("Time=%t: Q = %b", $time, Q);
    end

endmodule