`timescale 1ns / 1ps

module EdgeTriggered_flipFlop_tb;

reg D;
reg clk;

wire Q;
wire Qbar;

main uut (
    .D(D),
    .clk(clk),
    .Q(Q),
    .Qbar(Qbar)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    D = 0;

    #7;
    D = 1;

    #10;
    D = 0;

    #10;
    D = 1;

    #3;
    D = 0;

    #20;
    $finish;

end

endmodule