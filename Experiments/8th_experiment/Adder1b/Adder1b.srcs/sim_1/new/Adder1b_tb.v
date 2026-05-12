`timescale 1ns / 1ps

module Adder1b_tb();

// Inputs
reg A;
reg B;
reg Cin;

// Outputs
wire S;
wire Cout;

// Instantiate UUT
Adder1b uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout)
);

initial begin
    // 遍历所有输入组合（8种情况）
    A=0; B=0; Cin=0; #10;
    A=0; B=0; Cin=1; #10;
    A=0; B=1; Cin=0; #10;
    A=0; B=1; Cin=1; #10;
    A=1; B=0; Cin=0; #10;
    A=1; B=0; Cin=1; #10;
    A=1; B=1; Cin=0; #10;
    A=1; B=1; Cin=1; #10;

    $stop;
end

endmodule