`timescale 1ns / 1ps

module Mux4to1b4_tb();

// Inputs
reg [3:0] D0;
reg [3:0] D1;
reg [3:0] D2;
reg [3:0] D3;
reg [1:0] S;

// Output
wire [3:0] Y;

// 实例化被测模块（注意名字是 Mux4to1b4）
Mux4to1b4 uut (
    .D0(D0),
    .D1(D1),
    .D2(D2),
    .D3(D3),
    .S(S),
    .Y(Y)
);

initial begin
    // 初始化输入（给不同值，方便区分）
    D0 = 4'b0001;
    D1 = 4'b0010;
    D2 = 4'b0100;
    D3 = 4'b1000;

    // 依次测试选择信号
    S = 2'b00; #10;   // 期望 Y = D0
    S = 2'b01; #10;   // 期望 Y = D1
    S = 2'b10; #10;   // 期望 Y = D2
    S = 2'b11; #10;   // 期望 Y = D3

    // 再换一组数据（防止"巧合正确"）
    D0 = 4'b1010;
    D1 = 4'b1100;
    D2 = 4'b0110;
    D3 = 4'b1111;

    S = 2'b00; #10;
    S = 2'b01; #10;
    S = 2'b10; #10;
    S = 2'b11; #10;

    $finish;
end

endmodule