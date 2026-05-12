`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/26 14:04:17
// Design Name: 
// Module Name: ex4_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ns

// Filename: ex4_tb.v
module ex4_tb ();

    reg I0;
    reg I1;
    reg I2;

    wire res;

    main test_inst (
        .I0(I0),
        .I1(I1),
        .I2(I2),
        .res(res)
    );

    initial begin
        #5;
        I0 = 1'b0; I1 = 1'b0; I2 = 1'b0; #5;
        I0 = 1'b0; I1 = 1'b0; I2 = 1'b1; #5;
        I0 = 1'b0; I1 = 1'b1; I2 = 1'b0; #5;
        I0 = 1'b0; I1 = 1'b1; I2 = 1'b1; #5;
        I0 = 1'b1; I1 = 1'b0; I2 = 1'b0; #5;
        I0 = 1'b1; I1 = 1'b0; I2 = 1'b1; #5;
        I0 = 1'b1; I1 = 1'b1; I2 = 1'b0; #5;
        I0 = 1'b1; I1 = 1'b1; I2 = 1'b1; #5;
        #5;
        I0 = 1'b0; I1 = 1'b0; I2 = 1'b0; #5;
    end

endmodule
