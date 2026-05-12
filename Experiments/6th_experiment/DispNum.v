module DispNum(
    input  wire [1:0] BTN,      // 两个按钮：BTN[0]接LE，BTN[1]接point
    input  wire [7:0] SW,       // 8个开关：低4位数字，高4位AN控制
    output wire [7:0] SEGMENT,  // 数码管段选（含小数点）
    output wire [3:0] AN,       // 数码管位选
    output wire       BTN_X     // 按钮行选，恒为0
);

    // 按钮行选恒为0
    assign BTN_X = 1'b0;

    // 高4位开关直接控制位选
    assign AN = SW[7:4];

    // 内部连线
    wire a, b, c, d, e, f, g, p;

    // 实例化译码器
    MyMC14495 u_decoder (
        .D0   (SW[0]),
        .D1   (SW[1]),
        .D2   (SW[2]),
        .D3   (SW[3]),
        .LE   (BTN[0]),    // LE低有效
        .point(BTN[1]),    // point高有效
        .p    (p),
        .a    (a),
        .b    (b),
        .c    (c),
        .d    (d),
        .e    (e),
        .f    (f),
        .g    (g)
    );

    // 拼接SEGMENT总线
    // 按照要求：SEGMENT[7] = p
    // SEGMENT[6] = g, SEGMENT[5] = f, SEGMENT[4] = e,
    // SEGMENT[3] = d, SEGMENT[2] = c, SEGMENT[1] = b, SEGMENT[0] = a
    assign SEGMENT = {p, g, f, e, d, c, b, a};

endmodule