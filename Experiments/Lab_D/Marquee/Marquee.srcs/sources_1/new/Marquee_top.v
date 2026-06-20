module Marquee_top(
    input        clk,         // 100 MHz main clock
    input  [3:0] SW,         // SW[1:0] for inc, SW[2]=load/shift, SW[3]=shift_in
    output [7:0] LED,        // shift register output Q[7:0]
    output [3:0] AN,
    output [7:0] SEGMENT
);

    wire [15:0] hexs_display;
    wire [15:0] num;
    wire [3:0]  regA, regB;
    wire clk_1s;

    // Extract regA and regB from CreateNumber (choose the appropriate nibbles)
    assign regA = num[15:12];   // controlled by SW[1] (btn[3])
    assign regB = num[11:8];    // controlled by SW[0] (btn[2])

    // Display regA on leftmost digit, regB on second left, others blank (show 0)
    assign hexs_display = {regA, regB, 8'b0000_0000};

    // 1 Hz clock for shift register (slow visual effect)
    clk_1s clk_div (
        .clk(clk),
        .clk_1s(clk_1s)
    );

    // Button-triggered increment module
    CreateNumber u_create (
        .btn({2'b00, SW[0], SW[1]}),   // btn[1]=SW[0] (regB), btn[0]=SW[1] (regA)
        .num(num)
    );

    // 7-segment display
    DisplayNumber u_display (
        .clk(clk),
        .rst(1'b0),
        .hexs(hexs_display),
        .points(4'b0000),
        .LEs(4'b0000),
        .AN(AN),
        .SEGMENT(SEGMENT)
    );

    // 8-bit right-shift register (controlled by SW[2] and SW[3])
    ShiftReg8b u_shift (
        .clk(clk_1s),
        .shiftn_loadp(SW[2]),   // 1: load {regA,regB}, 0: shift right
        .shift_in(SW[3]),
        .par_in({regA, regB}),
        .Q(LED)
    );

endmodule