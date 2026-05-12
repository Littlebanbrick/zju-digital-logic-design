`timescale 1ns / 1ps

module MasterSlave_flipFlop_tb;

reg S;
reg R;
reg clk;

wire mid_Q;
wire Q;
wire Qbar;

main uut (
    .S(S),
    .R(R),
    .clk(clk),
    .mid_Q(mid_Q),
    .Q(Q),
    .Qbar(Qbar)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    // Hold
    S = 1;
    R = 1;

    // Set
    #8;
    S = 0;

    #10;
    S = 1;

    // Reset
    #12;
    R = 0;

    #10;
    R = 1;

    // One-time sampling test
    #7;
    S = 0;

    #2;
    S = 1;

    #20;
    $finish;

end

endmodule