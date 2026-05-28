module top(
    input clk,
    input [1:0] SW,
    output [3:0] AN,
    output [7:0] SEGMENT
);

    wire clk_10ms;
    wire clk_100ms;
    clk_10ms clk_div_10ms (.clk(clk), .clk_10ms(clk_10ms));
    clk_100ms clk_div_100ms (.clk(clk), .clk_100ms(clk_100ms));

    wire clk_counter = (SW[0] == 1'b0) ? clk_10ms : clk_100ms;

    wire [3:0] hour_tens, hour_ones, min_tens, min_ones;

    wire min_ones_tc   = (min_ones == 4'd9);
    wire min_tens_tc   = (min_tens == 4'd5) & min_ones_tc;
    wire hour_ones_tc  = (hour_tens == 4'd2) ? (hour_ones == 4'd3) : (hour_ones == 4'd9);
    wire hour_tens_tc  = (hour_tens == 4'd2) & hour_ones_tc & min_tens_tc;

    wire min_ones_ldn  = ~(min_ones_tc | SW[1]);
    wire min_tens_ldn  = ~(min_tens_tc | SW[1]);
    wire hour_ones_ldn = ~(hour_ones_tc & min_tens_tc | SW[1]);
    wire hour_tens_ldn = ~(hour_tens_tc | SW[1]);

    wire [3:0] min_ones_D  = 4'd0;
    wire [3:0] min_tens_D  = 4'd0;
    wire [3:0] hour_ones_D = SW[1] ? 4'd3 : 4'd0;
    wire [3:0] hour_tens_D = SW[1] ? 4'd2 : 4'd0;

    wire min_ones_ctt  = 1'b1;
    wire min_tens_ctt  = min_ones_tc;
    wire hour_ones_ctt = min_tens_tc;
    wire hour_tens_ctt = hour_ones_tc & min_tens_tc;


    My74LS161 u_min_ones (
        .CP  (clk_counter),
        .CRn (1'b1),
        .LDn (min_ones_ldn),
        .D   (min_ones_D),
        .CTT (min_ones_ctt),
        .CTP (1'b1),
        .Q   (min_ones),
        .CO  ()
    );

    My74LS161 u_min_tens (
        .CP  (clk_counter),
        .CRn (1'b1),
        .LDn (min_tens_ldn),
        .D   (min_tens_D),
        .CTT (min_tens_ctt),
        .CTP (1'b1),
        .Q   (min_tens),
        .CO  ()
    );

    My74LS161 u_hour_ones (
        .CP  (clk_counter),
        .CRn (1'b1),
        .LDn (hour_ones_ldn),
        .D   (hour_ones_D),
        .CTT (hour_ones_ctt),
        .CTP (1'b1),
        .Q   (hour_ones),
        .CO  ()
    );

    My74LS161 u_hour_tens (
        .CP  (clk_counter),
        .CRn (1'b1),
        .LDn (hour_tens_ldn),
        .D   (hour_tens_D),
        .CTT (hour_tens_ctt),
        .CTP (1'b1),
        .Q   (hour_tens),
        .CO  ()
    );

    DisplayNumber display_inst (
        .clk     (clk),
        .hexs    ({hour_tens, hour_ones, min_tens, min_ones}),
        .points  (4'b0100),
        .rst     (1'b0),
        .LEs     (4'b0000),
        .AN      (AN),
        .SEGMENT (SEGMENT)
    );

endmodule