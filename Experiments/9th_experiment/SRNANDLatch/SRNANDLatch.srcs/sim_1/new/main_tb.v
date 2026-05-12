`timescale 1ns / 1ps

module main_tb;

reg Rn;
reg Sn;

wire Q;
wire Qbar;

main uut (
    .Rn(Rn),
    .Sn(Sn),
    .Q(Q),
    .Qbar(Qbar)
);

initial begin

    // Hold state
    Rn = 1;
    Sn = 1;

    // Set (low active)
    #10;
    Sn = 0;
    Rn = 1;

    #10;
    Sn = 1;

    // Hold
    #10;

    // Reset (low active)
    #10;
    Rn = 0;
    Sn = 1;

    #10;
    Rn = 1;

    // Invalid state
    #10;
    Rn = 0;
    Sn = 0;

    #10;
    Rn = 1;
    Sn = 1;

    #20;
    $finish;

end

endmodule