`timescale 1ns / 1ps

module RevCounter_tb();

    reg clk;
    reg rst;
    reg s;
    wire [15:0] cnt;
    wire Rc;

    // 实例化待测模块
    RevCounter uut (
        .clk(clk),
        .rst(rst),
        .s(s),
        .cnt(cnt),
        .Rc(Rc)
    );

    // 时钟生成：周期 10ns
    always #5 clk = ~clk;

    initial begin
        // 初始化
        clk = 0;
        rst = 0;
        s   = 0;

        // 1. 测试同步复位
        rst = 1;
        #10;                        // 第一个时钟上升沿，复位生效
        rst = 0;
        #10;
        $display("After reset: cnt = %h, Rc = %b", cnt, Rc);

        // 2. 自增测试（s=0）
        s = 0;
        // 计数几个周期
        repeat(20) #10;
        $display("After 20 inc cycles: cnt = %h, Rc = %b", cnt, Rc);

        // 3. 自减测试（s=1）
        s = 1;
        repeat(5) #10;
        $display("After 5 dec cycles: cnt = %h, Rc = %b", cnt, Rc);

        // 4. 边界测试：从 0 自减
        s = 1;
        // 手动设置为0
        rst = 1; #10; rst = 0;
        #10;                        // cnt=0, s=1 -> Rc应为1
        $display("cnt=0, s=1 -> cnt = %h, Rc = %b", cnt, Rc);
        #10;                        // 执行一次自减，cnt应该变为FFFF
        $display("After dec from 0: cnt = %h, Rc = %b", cnt, Rc);

        // 5. 边界测试：从 FFFF 自增
        s = 0;
        // 手动设置为FFFF：先自减到FFFF，然后切s=0
        s = 1;                      // 减模式
        // 从0减一次到FFFF，当前cnt=0，减一次
        #10;                        // cnt=0 -> FFFF
        s = 0;                      // 切回增模式
        #10;                        // 现在cnt=FFFF, s=0，Rc应为1
        $display("cnt=FFFF, s=0 -> cnt = %h, Rc = %b", cnt, Rc);
        #10;                        // 自增，cnt变为0000
        $display("After inc from FFFF: cnt = %h, Rc = %b", cnt, Rc);

        // 6. 动态切换方向
        s = 0;
        repeat(3) #10;              // 增3次
        s = 1;
        repeat(2) #10;              // 减2次
        $display("After direction change: cnt = %h, Rc = %b", cnt, Rc);

        #50 $finish;
    end

    // 波形输出（VCD）
    initial begin
        $dumpfile("RevCounter_tb.vcd");
        $dumpvars(0, RevCounter_tb);
    end

endmodule