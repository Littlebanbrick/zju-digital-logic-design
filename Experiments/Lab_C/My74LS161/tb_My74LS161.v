`timescale 1ns / 1ps

module tb_My74LS161();

    // Testbench signals
    reg CP;
    reg CRn;
    reg LDn;
    reg [3:0] D;
    reg CTT;
    reg CTP;
    wire [3:0] Q;
    wire CO;

    // Instantiate the Unit Under Test (UUT)
    My74LS161 uut (
        .CP(CP),
        .CRn(CRn),
        .LDn(LDn),
        .D(D),
        .CTT(CTT),
        .CTP(CTP),
        .Q(Q),
        .CO(CO)
    );

    // Clock generation: 10ns period
    always #5 CP = ~CP;

    initial begin
        // Initialize
        CP = 0;
        CRn = 1;
        LDn = 1;
        D = 4'b0000;
        CTT = 0;
        CTP = 0;

        // 1. Test asynchronous clear (CRn=0)
        #10; // Wait for one clock edge (optional, clear works async)
        CRn = 0; // Assert clear
        #10;     // Hold for some time, Q should be 0 immediately
        CRn = 1; // Release clear
        #10;
        // Check Q==0 and CO==0 after clear
        $display("After async clear: Q = %h, CO = %b", Q, CO);

        // 2. Test synchronous load (LDn=0)
        D = 4'b0101; // Load value 5
        LDn = 0;
        #10; // At this clock edge, Q should become 5
        LDn = 1;
        #10;
        $display("After load: Q = %h, CO = %b", Q, CO);

        // 3. Test count enable (CTT and CTP)
        // Enable counting
        CTT = 1;
        CTP = 1;
        repeat(6) #10; // Count 6 cycles: 5->6->7->8->9->A
        $display("After 6 counts from 5: Q = %h, CO = %b", Q, CO);

        // Disable counting by deasserting CTT
        CTT = 0;
        repeat(3) #10; // Should hold value
        $display("After hold (CTT=0): Q = %h, CO = %b", Q, CO);

        // Re-enable and count to overflow
        CTT = 1;
        repeat(6) #10; // Continue from A: B, C, D, E, F, 0
        #10; // Extra cycle to observe CO during F
        $display("After rolling over: Q = %h, CO = %b", Q, CO);

        // 4. Test carry output CO
        // Force Q to F by load to check CO immediately
        CRn = 0; #10; CRn = 1; // Clear
        D = 4'b1111; // Load 15
        LDn = 0;
        #10; // Q=15, CO should be 1 (since Q==15 and CTP=1)
        LDn = 1;
        #10;
        $display("At Q=F: Q = %h, CO = %b (should be 1)", Q, CO);

        // 5. Test priority of CRn over LDn and count
        CRn = 0; // Asynchronous clear while counting
        CTT = 1; CTP = 1;
        #5; // mid-cycle, Q should be reset to 0 immediately, not waiting for edge
        $display("Mid-cycle clear: Q = %h (should be 0)", Q);
        CRn = 1;
        #5; // Next edge, should still be 0
        $display("After clear release: Q = %h", Q);

        $finish;
    end

    // Optional: monitor changes
    always @(posedge CP) begin
        #1; // small delay to capture output after edge
        $display("Time=%t: Q=%h, CO=%b", $time, Q, CO);
    end

endmodule