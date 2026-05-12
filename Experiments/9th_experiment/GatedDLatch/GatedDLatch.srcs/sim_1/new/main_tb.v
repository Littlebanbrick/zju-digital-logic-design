`timescale 1ns / 1ps

module GatedDLatch_tb;

reg D;
reg C;

wire Q;
wire Qbar;

GatedDLatch uut (
    .D(D),
    .C(C),
    .Q(Q),
    .Qbar(Qbar)
);

initial begin

    // =====================================================
    // Initialize latch to a stable state
    // =====================================================

    C = 1'b1;
    D = 1'b0;
    #20;

    // =====================================================
    // C = 0 : hold mode
    // D changes should NOT affect Q
    // =====================================================

    C = 1'b0;

    D = 1'b0;
    #20;

    D = 1'b1;
    #20;

    D = 1'b0;
    #20;

    // =====================================================
    // C = 1 : transparent mode
    // Q follows D immediately
    // This demonstrates race-through behavior
    // =====================================================

    C = 1'b1;

    D = 1'b1;
    #20;

    D = 1'b0;
    #20;

    D = 1'b1;
    #20;

    D = 1'b0;
    #20;

    D = 1'b1;
    #20;

    // =====================================================
    // Disable again
    // Q should hold last value
    // =====================================================

    C = 1'b0;

    D = 1'b0;
    #20;

    D = 1'b1;
    #20;

    $finish;

end

endmodule