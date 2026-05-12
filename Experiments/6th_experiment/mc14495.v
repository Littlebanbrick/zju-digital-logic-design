module MyMC14495(
    input D0, D1, D2, D3,      // 4位二进制输入
    input LE,                  // 锁存使能，低电平有效
    input point,               // 小数点输入，高电平有效
    output reg p,              // 小数点输出，低电平有效
    output reg a, b, c, d, e, f, g  // 七段笔画输出，低电平有效
);

    reg [3:0] latched_data;

    // LE 低电平时透明传输，高电平时锁存（因为 LE 低有效）
    always @(*) begin
        if (LE)                // LE=0 时更新，LE=1 时保持
            latched_data = latched_data; // 保持
        else
            latched_data = {D3, D2, D1, D0};
    end

    always @(*) begin
        p = ~point;   // 小数点输出低有效，所以对输入取反

        case (latched_data)
            // 以下段码均为取反后的值（低电平有效）
            4'd0: {a,b,c,d,e,f,g} = 7'b0000001;  // 显示 0
            4'd1: {a,b,c,d,e,f,g} = 7'b1001111;  // 显示 1
            4'd2: {a,b,c,d,e,f,g} = 7'b0010010;  // 显示 2
            4'd3: {a,b,c,d,e,f,g} = 7'b0000110;  // 显示 3
            4'd4: {a,b,c,d,e,f,g} = 7'b1001100;  // 显示 4
            4'd5: {a,b,c,d,e,f,g} = 7'b0100100;  // 显示 5
            4'd6: {a,b,c,d,e,f,g} = 7'b0100000;  // 显示 6
            4'd7: {a,b,c,d,e,f,g} = 7'b0001111;  // 显示 7
            4'd8: {a,b,c,d,e,f,g} = 7'b0000000;  // 显示 8
            4'd9: {a,b,c,d,e,f,g} = 7'b0000100;  // 显示 9
            4'd10:{a,b,c,d,e,f,g} = 7'b0001000;  // 显示 A
            4'd11:{a,b,c,d,e,f,g} = 7'b1100000;  // 显示 b
            4'd12:{a,b,c,d,e,f,g} = 7'b0110001;  // 显示 C
            4'd13:{a,b,c,d,e,f,g} = 7'b1000010;  // 显示 d
            4'd14:{a,b,c,d,e,f,g} = 7'b0110000;  // 显示 E
            4'd15:{a,b,c,d,e,f,g} = 7'b0111000;  // 显示 F
            default: {a,b,c,d,e,f,g} = 7'b1111111; // 全灭
        endcase
    end

endmodule