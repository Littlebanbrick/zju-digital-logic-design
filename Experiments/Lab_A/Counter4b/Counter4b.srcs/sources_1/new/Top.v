module Top( 
    input wire clk,
    input wire [1:0] SW,      // SW[1]=rst, SW[0]=direction (0=up, 1=down)
    output wire LED,
    output wire [7:0] SEGMENT,
    output wire [3:0] AN
);

    wire [15:0] cnt;
    wire clk_1s;

    /* 1Hz clock divider for counting */
    clk_1s clk_div_1s (.clk(clk), .clk_1s(clk_1s));

    /* 16-bit reversible counter */
    RevCounter counter(.clk(clk_1s), .rst(SW[1]), .s(SW[0]), .cnt(cnt), .Rc(LED));

    /* 4-digit multiplexed display */
    DisplayNumber display(.clk(clk), .rst(1'b0), .hexs(cnt),
                          .LEs(4'b0000), .points(4'b0000),
                          .AN(AN), .SEGMENT(SEGMENT));

endmodule
