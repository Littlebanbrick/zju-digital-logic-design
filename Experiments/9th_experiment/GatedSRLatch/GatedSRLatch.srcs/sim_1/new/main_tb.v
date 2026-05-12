`timescale 1ns / 1ps

module GatedSRLatch_tb;

reg R;
reg S;
reg C;

wire Q;
wire Qbar;

main uut (
    .R(R),
    .S(S),
    .C(C),
    .Q(Q),
    .Qbar(Qbar)
);

initial begin

    // =====================================================
    // C = 0 : latch disabled
    // =====================================================

    C = 1'b0;

    // S=1 R=1 : hold
    S = 1'b1;
    R = 1'b1;
    #20;

    // S=0 R=1 : should NOT set
    S = 1'b0;
    R = 1'b1;
    #20;

    // S=1 R=0 : should NOT reset
    S = 1'b1;
    R = 1'b0;
    #20;

    // S=0 R=0 : should still have no effect
    S = 1'b0;
    R = 1'b0;
    #20;

    // =====================================================
    // C = 1 : latch enabled
    // =====================================================

    C = 1'b1;

    // S=1 R=1 : hold
    S = 1'b1;
    R = 1'b1;
    #20;

    // S=0 R=1 : SET
    S = 1'b0;
    R = 1'b1;
    #20;

    // S=1 R=1 : hold
    S = 1'b1;
    R = 1'b1;
    #20;

    // S=1 R=0 : RESET
    S = 1'b1;
    R = 1'b0;
    #20;

    // S=1 R=1 : hold
    S = 1'b1;
    R = 1'b1;
    #20;

    // S=0 R=0 : INVALID STATE
    // placed at the end intentionally

    S = 1'b0;
    R = 1'b0;
    #20;

    $finish;

end

endmodule