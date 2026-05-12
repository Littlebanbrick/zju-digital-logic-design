`timescale 1ns / 1ps

module AddSub4b_tb();

// Inputs
reg [3:0] A;
reg [3:0] B;
reg Ctrl;  // 0: ADD, 1: SUB

// Outputs
wire [3:0] S;
wire Cout;

// Instantiate UUT
AddSub4b uut (
    .A(A),
    .B(B),
    .Ctrl(Ctrl),
    .S(S),
    .Cout(Cout)
);

initial begin
    // =====================
    // 加法测试 (Ctrl = 0)
    // =====================
    Ctrl = 0;

    // 普通情况
    A = 4'b0011; B = 4'b0101; #10; // 3 + 5

    // 边界：溢出
    A = 4'b1111; B = 4'b0001; #10; // 15 + 1

    // =====================
    // 减法测试 (Ctrl = 1)
    // =====================
    Ctrl = 1;

    // 普通情况
    A = 4'b1000; B = 4'b0011; #10; // 8 - 3

    // 边界：借位
    A = 4'b0000; B = 4'b0001; #10; // 0 - 1

    // 相等情况
    A = 4'b0110; B = 4'b0110; #10; // 6 - 6

    $stop;
end

endmodule