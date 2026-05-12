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
    Lab 7 多路选择器
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
  #text(size: 20pt)[时间：2026-4-16]
  #v(0.5em)
  #text(size: 20pt)[地点：紫金港东四509室]
]

#pagebreak()

// Main report starts here

= 第一部分：操作方法与实验步骤

== 多路选择器的实现

=== 一位 4-1 多路选择器（Mux4to1）

本实验首先在 Logisim 中设计了一位 4-1 多路选择器。该模块包含输入端 D0、D1、D2、D3，选择信号 S[1:0]，以及输出端 Y。

根据多路选择器的功能，当选择信号 S 取不同值时，输出 Y 分别等于对应输入端的数据。通过与门、或门、非门等基本逻辑门组合实现该功能，并完成电路连接与调试。

Logisim中连接的电路图如下：\
#image("Mux4to1.png")

=== 四位 4-1 多路选择器（Mux4to1b4）

在一位多路选择器的基础上，将其扩展为四位结构。具体方法为对每一位分别使用一个一位多路选择器，并共享同一组选择信号 S[1:0]，最终输出四位数据 Y[3:0]。

完成电路设计后，通过 Logisim 导出为 Verilog 代码，并导入 Vivado 进行仿真验证。

Logisim中连接的电路图如下：\
#image("Mux4to1b4.png")

=== 仿真验证

编写测试文件，对不同选择信号 S 及输入数据组合进行测试，观察输出 Y 是否符合预期，从而验证多路选择器功能的正确性。

编写的仿真文件Mux4to1b4_tb.v源代码如下所示：\
```Verilog
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

//
Mux4to1b4 uut (
    .D0(D0),
    .D1(D1),
    .D2(D2),
    .D3(D3),
    .S(S),
    .Y(Y)
);

initial begin

    D0 = 4'b0001;
    D1 = 4'b0010;
    D2 = 4'b0100;
    D3 = 4'b1000;                                                                            


    S = 2'b00; #10;   
    S = 2'b01; #10;  
    S = 2'b10; #10;  
    S = 2'b11; #10; 


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
```
\
\
== 时钟分频器（clkdiv）

根据实验要求，实现一个 32 位计数器作为时钟分频器。其输入为时钟信号 clk 和复位信号 rst，输出为 div_res[31:0]。
模块功能是在每个时钟上升沿对计数器进行加一操作，当复位信号有效时清零。通过选择 div_res 的高位（如第 18、17 位）作为扫描信号，实现低频扫描控制。

== 动态扫描模块设计

=== DisplaySync 模块

DisplaySync 模块用于实现数字选择与数码管使能信号的同步控制。该模块通过 4-1 多路选择器，根据扫描信号 scan[1:0]，
在四组输入数据中选择当前需要显示的一组，同时输出对应的 AN 信号（如 1110、1101、1011、0111），并同步生成 point 和 LE 信号。

Logisim中DisplaySync模块电路图如下：\
#image("DisplaySync.png")

\
\
\
\
\
\
\
\
\
\

=== DisplayNumber 模块

DisplayNumber 模块整合 clkdiv、DisplaySync 和 MyMC14495 三个子模块。首先利用 clkdiv 生成分频信号，并提取高位作为扫描信号 scan；
然后将 scan 输入 DisplaySync，选择当前显示的数据及对应使能信号；最后将结果输入 MyMC14495 模块进行七段译码，并输出 SEGMENT 和 AN 控制信号，实现数码管动态显示。

Logisim中DisplayNumber模块电路图如下：\
#image("DisplayNumber.png")

== 顶层模块实现与下板测试

在顶层模块中，使用开关 SW 控制输入数据、小数点及使能信号，使用按钮 btn 控制各位数字自增。完成电路设计后，生成比特流文件并下载到 FPGA 开发板上，对系统功能进行实际验证。

= 第二部分：实验结果与分析

== 多路选择器功能验证

通过Mux4to1b4_tb.v仿真结果如下：\
#image("simulation.png")

通过仿真结果可以观察到，当选择信号 S 分别取 00、01、10、11 时，输出 Y 能够正确对应输入 D0、D1、D2、D3，说明多路选择器功能实现正确。

== 时钟分频与扫描效果

使用 clkdiv 的高位信号作为扫描信号后，扫描频率降低至人眼可接受范围。四个数码管依次被点亮，由于视觉暂留效应，最终观察到四个数码管能够同时稳定显示不同数字。

我们记录了两组结果，分别是该四个数码管显示AAAA和E876时的情况：

#grid(
  columns: 2,
  gutter: 1em,
  [
    #figure(
      image("E876.jpg", width: 100%),
      caption: [E876]
    )
  ],
  [
    #figure(
      image("AAAA.jpg", width: 100%),
      caption: [AAAA]
    )
  ]
)

== DisplaySync 模块分析

DisplaySync 模块能够根据扫描信号正确选择当前显示的数据，并输出对应的 AN 使能信号。实验结果表明，该模块能够保证显示位置与数据内容的同步，满足动态扫描的要求。

== 系统整体功能验证

在 FPGA 开发板上的测试结果表明，系统能够正确实现四位数码管的动态显示功能。按钮可实现对应位数字的自增，开关可控制小数点与使能信号，系统运行稳定，符合实验设计目标。



= 第三部分：讨论与心得

在本次实验中，我在电路设计与工具使用过程中遇到了一些较为典型但具有代表性的问题。例如，在使用 Logisim 进行模块设计与导出 Verilog 时，由于部分元件未正确命名，导致导出失败；在处理总线分线器（splitter）时，曾将多位信号错误地合并连接到同一导线上，引发信号冲突（红线问题）；此外，在模块层级连接中，也曾因接口信号的使用方式不当，出现子模块看似正常但整体系统输出异常的情况。这些问题促使我更加重视数字电路设计中“信号唯一驱动”“位宽匹配”以及“模块接口规范”的基本原则，并学会通过逐层排查的方法定位错误。

通过本次实验，我不仅加深了对多路选择器、时钟分频以及动态扫描原理的理解，也进一步体会到模块化设计在复杂系统中的重要性。在调试过程中，我逐渐掌握了从整体到局部的分析思路，能够通过观察波形或错误现象反推问题所在。同时，本实验也让我更加熟悉了 Logisim 与 Verilog 之间的对应关系，为后续更复杂的数字系统设计打下了基础。整体而言，本次实验不仅提升了我的工程实践能力，也增强了我面对复杂问题时的耐心与系统性思考能力。


= 附录：思考题

== 一、扫描信号频率分析

在实验中，使用 `clkdiv` 模块生成分频信号：

```
output reg [31:0] div_res;
```

其中 `div_res[i]` 在每个上升沿加 1，相当于二进制计数器。

`div_res[0]` 的频率为输入时钟 `clk` 的一半：

```
f_div_res[0] = f_clk / 2
```

一般公式：

```
f_div_res[i] = f_clk / 2^(i+1)
```

因此：

```
f_div_res[18] = f_clk / 2^19
f_div_res[17] = f_clk / 2^18

```

如果希望扫描频率减慢为原来的 1/4 倍，只需选择高两位作为扫描信号，例如：
```
div_res[20:19]

```
因为高两位的频率比原来低 2^2 = 4 倍。


== 二、数字选择与使能不同步错误分析

=== 正确同步时序示意

```
T:     t0   t1   t2   t3   t4   t5   t6   t7
Num:   D0   D1   D2   D3   D0   D1   D2   D3
EN:    E0   E1   E2   E3   E0   E1   E2   E3

```

每个数字对应自己的使能信号，显示正常。

=== 不同步时序示意

```
T:     t0   t1   t2   t3   t4   t5
Num:   D0   D1   D2   D3   D0   D1
EN:    E1   E2   E3   E0   E1   E2

```

- 结果：
  - D0 的位置被 E1 使能 → 显示错误数字
  - D1 的位置被 E2 使能 → 显示错误数字
  - 四个数码管位置与数值错位
  - 视觉上数字跳动混乱