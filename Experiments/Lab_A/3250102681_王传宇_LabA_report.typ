// English Report Template

// ===== Code Block Style Optimization =====

// 控制代码块外观（背景、边距）
// 只处理“代码块”
#show raw.where(block: true): set block(
  fill: luma(250),
  inset: 6pt,
  radius: 3pt
)

#show raw.where(block: true): set text(
  size: 9pt,
  font: "Courier New"
)

#show raw.where(block: true): set par(
  leading: 1.15em
)

#set page(
  paper: "a4",
  margin: (left: 2.6cm, right: 2.6cm, top: 2.4cm, bottom: 2.8cm),
  numbering: "1",
  number-align: bottom + center,
  header: context [
    #text(size: 12pt, fill: gray.darken(25%))[DLD Report]
    #h(1fr)
    #text(size: 12pt, fill: gray.darken(25%))[#datetime.today().display("[month repr:short] [day], [year]")]
  ],
  footer: context align(center)[
    #text(size: 11pt, fill: gray.darken(50%))[#counter(page).display()]
  ],
)

// Typography: classic academic style
#set text(
  font: ("Times New Roman", "Georgia"),
  size: 14pt,
  lang: "en",
)

// Paragraph style for English reports
#set par(
  justify: true,
  first-line-indent: 0em,
  leading: 0.75em,
  spacing: 0.85em,
)

// Heading hierarchy
#set heading(numbering: "1.")
#show heading.where(level: 1): it => [
  #v(0.9em)
  #text(size: 20pt, weight: "bold", it.body)
  #v(0.35em)
]
#show heading.where(level: 2): it => [
  #v(0.55em)
  #text(size: 15pt, weight: "semibold", it.body)
  #v(0.25em)
]

// Cover page
#align(center + horizon)[
  #v(0%)
  #text(size: 35pt, weight: "bold")[
    Lab A
    \
     Synchronous counter
  ]
  #image("icon_ZJU.png", width: 40%)
  #v(2em)
  #text(size: 20pt)[课程名称：数字逻辑电路设计]
  #v(0.5em)
  #text(size: 20pt)[作者：王传宇 3250102681]
  #v(0.5em)
  #text(size: 20pt)[专业：计算机科学与技术]
  #v(0.5em)
  #text(size: 20pt)[邮箱：3250102681\@zju.edu.cn]
  #v(0.5em)
  #text(size: 20pt)[时间：2026-5-14]
  #v(0.5em)
  #text(size: 20pt)[地点：紫金港东四509室]
]

#pagebreak()

// Main report starts here

= 写在前面：触发器激励函数化简

首先，写出四个函数的原表达式：

#image("BeforeSimplification.png")

以下是化简过程及化简结果：

#image("Simplication.jpg")

= 第一部分：操作方法与实验步骤

== 任务一：四位同步二进制计数器

=== 激励函数推导与原理图绘制
在 Logisim‑evolution 中绘制 `Counter4b` 原理图，使用 FD 空壳模块和基本门电路。

#figure(image("Counter4b_circuit.png", width: 80%), caption: [Counter4b 原理图])

=== 导出 Verilog 并替换 FD 模块
导出原理图为 `Counter4b.v`。

将 `FD.v` 的内容替换为实验文档中给出的代码：

  ```verilog
  module FD(                                                                      
      input clk,
      input D,
      output Q,
      output Qn
  );
      reg Q_reg = 1'b0;
      always @(posedge clk) begin
          Q_reg <= D;    
      end
      assign Q = Q_reg;
      assign Qn = ~Q_reg;
  endmodule
  ```


=== 仿真验证
编写 `Counter4b_tb.v`，例化计数器并施加时钟激励。

  ```verilog
  `timescale 1ns / 1ps                                                            

  module Counter4b_tb;

  reg clk;

  wire Qa;
  wire Qb;
  wire Qc;
  wire Qd;
  wire Rc;

  // DUT
  Counter4b uut (
      .Qa(Qa),
      .Qb(Qb),
      .Qc(Qc),
      .Qd(Qd),
      .Rc(Rc),
      .clk(clk)
  );

  // clock generation
  initial begin
      clk = 0;
      forever #5 clk = ~clk;
  end

  // simulation
  initial begin

      // Run enough clock cycles
      // to traverse all 16 counter states

      #200;

      $finish;
  end

  endmodule
  ```

在 Vivado Simulator 中运行仿真，检查 Qd～Qa 的递增波形及 Rc 信号。

=== 顶层集成与下板测试
创建顶层模块 `Top.v`，例化 `clk_1s`、`Counter4b` 和 `DispNum`。

添加约束文件，分配引脚。

生成比特流并下载到开发板，观察数码管是否循环显示 0～F，LED 是否在计数到 F 时点亮。

== 任务二：十六位可逆同步二进制计数器

=== 编写 RevCounter 模块
在提供的代码框架中，用 `always @(posedge clk)` 实现同步复位与方向控制。

用 `assign` 实现组合逻辑进位信号 Rc。

完整代码：
  ```verilog
  module RevCounter(                                                              
      input wire clk,
      input wire rst,
      input wire s,
      output reg [15:0] cnt = 0,
      output wire Rc
  );
      always @(posedge clk) begin
          if (rst) begin
              cnt <= 16'd0;
          end else if (s == 1'b0) begin
              cnt <= cnt + 1'b1;
          end else begin
              cnt <= cnt - 1'b1;
          end
      end
      assign Rc = (s == 1'b0 && cnt == 16'hFFFF) ||
                  (s == 1'b1 && cnt == 16'h0000);
  endmodule
  ```

=== 仿真验证
编写 `RevCounter_tb.v`，覆盖复位、递增、递减、边界回绕和方向切换等场景。

```verilog
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
```

运行仿真，检查波形中 cnt 的变化与 Rc 的触发时机。

=== 顶层集成与下板测试
在顶层 `Top.v` 中例化 `clk_1s`、`RevCounter` 和 `DisplayNumber`。


综合、实现、生成比特流并下载。

拨动开关验证复位、增减、进位/借位指示是否正常。

= 第二部分：实验结果与分析

== 四位同步二进制计数器

=== 仿真波形分析

#figure(image("Counter4b_simulation.png", width: 90%), caption: [Counter4b 仿真波形])

从波形可以看出：
- 每个时钟上升沿，四位输出 Qd～Qa 按二进制递增，无毛刺或跳变。
- 在计数值达到 4‘b1111 时，Rc 输出高电平，下一个时钟周期计数器归零，Rc 变低。
- 整个计数周期为 0→1→2→…→15→0，符合同步二进制加法计数器的设计预期。

=== 下板验证结果

依次拍摄数码管显示 0、2、4、8、C 的状态：

#figure(image("0.jpg", width: 35%), caption: [显示 0])
#figure(image("2.jpg", width: 35%), caption: [显示 2])
#figure(image("4.jpg", width: 35%), caption: [显示 4])
#figure(image("8.jpg", width: 35%), caption: [显示 8])
#figure(image("C.jpg", width: 35%), caption: [显示 C])

实验现象：
- 数码管稳定地从 0 循环递增至 F，无缺漏或错位。
- 当显示 F 时，板上的进位指示灯（LED）点亮，与 Rc 信号一致。
- 说明同步计数器电路工作正常，级联逻辑无误，复位及初始状态符合预期。

== 十六位可逆同步二进制计数器

=== 仿真波形分析

#figure(image("RevCounter_simulation.png", width: 90%), caption: [RevCounter 仿真波形])

波形解读：
- 复位后 cnt 清零。
- s=0 时，每个时钟周期 cnt 加 1；s=1 时，cnt 减 1，方向切换即时生效。
- 当 cnt=0 且 s=1 时，Rc 立即输出高电平，下一时钟 cnt 翻转为 FFFF，Rc 随之变低。
- 当 cnt=FFFF 且 s=0 时，Rc 立即输出高电平，下一时钟 cnt 翻转为 0，Rc 随之变低。
- 所有边界回绕行为、进位/借位指示均与设计完全吻合，无亚稳态或竞争现象。

=== 下板验证结果

在 s=0（自增）和 s=1（自减）两种模式下分别抓取同一数值（19、1A、1B），对比计数方向：

#figure(image("19_ascend.jpg", width: 30%), caption: [s=0 自增至 0019])
#figure(image("1a_ascend.jpg", width: 30%), caption: [s=0 自增至 001A])
#figure(image("1b_ascend.jpg", width: 30%), caption: [s=0 自增至 001B])

#figure(image("19_descend.jpg", width: 30%), caption: [s=1 自减至 19])
#figure(image("1a_descend.jpg", width: 30%), caption: [s=1 自减至 1A])
#figure(image("1b_descend.jpg", width: 30%), caption: [s=1 自减至 1B])

现象与分析：
- 自增模式下，数码管末位随时间连续递增（…→18→19→1A→1B→…），完全符合预期。
- 自减模式下，数码管末位随时间连续递减（…→1B→1A→19→18→…），方向切换后立即生效。
- 当计数器从 0 减至 FFFF 或从 FFFF 增至 0 的瞬间，进位 LED 短暂点亮，与仿真中 Rc 信号一致。
- 整个设计在 1 Hz 时钟下运行稳定，数码管无闪烁或误码，验证了可逆同步计数及数据传输通路的正确性。

= 第三部分：讨论与心得

无。