module MyMC14495(
    input D0, D1, D2, D3,      // 4位二进制输入
    input LE,                  // 锁存使能，低电平有效
    input point,               // 小数点输入，高电平有效
    output reg p,              // 小数点输出，低电平有效
    output reg a, b, c, d, e, f, g  // 七段笔画输出，低电平有效
);

    // 锁存的4位数据
    reg [3:0] latched_data;

    // 锁存逻辑：LE=0 时透明，LE=1 时保持
    always @(*) begin
        if (LE)                // LE=1 时锁存（保持不变）
            latched_data = latched_data;
        else                   // LE=0 时更新
            latched_data = {D3, D2, D1, D0};
    end

    // 译码逻辑（段码为低有效，即 0 亮 1 灭）
    always @(*) begin
        // 小数点输出低有效，所以将 point 取反
        p = ~point;

        case (latched_data)
            // 以下段码顺序为 {a,b,c,d,e,f,g}，值为低有效（亮为0）
            4'd0: {a,b,c,d,e,f,g} = 7'b0000001;  // 0
            4'd1: {a,b,c,d,e,f,g} = 7'b1001111;  // 1
            4'd2: {a,b,c,d,e,f,g} = 7'b0010010;  // 2
            4'd3: {a,b,c,d,e,f,g} = 7'b0000110;  // 3
            4'd4: {a,b,c,d,e,f,g} = 7'b1001100;  // 4
            4'd5: {a,b,c,d,e,f,g} = 7'b0100100;  // 5
            4'd6: {a,b,c,d,e,f,g} = 7'b0100000;  // 6
            4'd7: {a,b,c,d,e,f,g} = 7'b0001111;  // 7
            4'd8: {a,b,c,d,e,f,g} = 7'b0000000;  // 8
            4'd9: {a,b,c,d,e,f,g} = 7'b0000100;  // 9
            4'd10:{a,b,c,d,e,f,g} = 7'b0001000;  // A
            4'd11:{a,b,c,d,e,f,g} = 7'b1100000;  // b
            4'd12:{a,b,c,d,e,f,g} = 7'b0110001;  // C
            4'd13:{a,b,c,d,e,f,g} = 7'b1000010;  // d
            4'd14:{a,b,c,d,e,f,g} = 7'b0110000;  // E
            4'd15:{a,b,c,d,e,f,g} = 7'b0111000;  // F
            default: {a,b,c,d,e,f,g} = 7'b1111111; // 全灭
        endcase
    end

endmodule