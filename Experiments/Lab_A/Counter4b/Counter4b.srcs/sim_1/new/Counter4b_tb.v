`timescale 1ns / 1ps

module Counter4b_tb;

reg clk;

wire Qa;
wire Qb;
wire Qc;
wire Qd;
wire Rc;

// DUT
Counter4b uut (
    .Qa(Qa),
    .Qb(Qb),
    .Qc(Qc),
    .Qd(Qd),
    .Rc(Rc),
    .clk(clk)
);

// clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// simulation
initial begin

    // Run enough clock cycles
    // to traverse all 16 counter states

    #200;

    $finish;
end

endmodule