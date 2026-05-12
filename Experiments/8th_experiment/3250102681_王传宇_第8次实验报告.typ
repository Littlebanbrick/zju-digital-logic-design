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
    Lab 8
    \
    全加器和四位加减法器
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
  #text(size: 20pt)[时间：2026-4-23]
  #v(0.5em)
  #text(size: 20pt)[地点：紫金港东四509室]
]

#pagebreak()

// Main report starts here

= 第一部分：操作方法与实验步骤

== 一位全加器（Adder1b）的实现与仿真

本实验首先实现了一位全加器模块 Adder1b。该模块包含三个输入信号 A、B 和进位输入 Cin，输出为和位 S 和进位输出 Cout。根据全加器的逻辑关系，其功能为对三个一位二进制数进行相加。Logisim中电路图如下：

#image("Adder1b.png")

在完成模块设计后，编写仿真文件，对所有可能的输入组合进行测试。由于输入共有 3 位，因此共有 2^3 = 8 种情况。通过在仿真中依次改变 A、B、Cin 的取值，观察输出 S 和 Cout 的变化情况，从而验证电路功能的正确性。

== 四位加减法器（AddSub4b）的实现与仿真

在一位全加器的基础上，进一步设计实现四位加减法器 AddSub4b。该模块包含两个四位输入 A 和 B，以及控制信号 Ctrl，其中 Ctrl = 0 表示执行加法运算，Ctrl = 1 表示执行减法运算。输出为四位结果 S 和进位/借位信号 Cout。根据全加器的逻辑关系，其功能为对三个一位二进制数进行相加。Logisim中电路图如下：

#image("AddSub4b.png")

在实现过程中，利用补码原理将减法转换为加法运算，通过控制信号对 B 进行取反并结合进位输入实现 A - B 的功能。

完成设计后，编写仿真文件，对加法与减法两种模式分别进行测试。对于每种运算，均选取至少两组输入数据，并特别测试边界情况，例如加法溢出（1111 + 0001）以及减法借位（0000 - 0001），以验证电路在特殊情况下的正确性。

= 第二部分：实验结果与分析

== 一位全加器仿真结果分析

首先，编写仿真文件`Adder1b_tb.v`：
```verilog
`timescale 1ns / 1ps                            
                                                                                                  
module Adder1b_tb();

// Inputs
reg A;
reg B;
reg Cin;
// Outputs
wire S;
wire Cout;

// Instantiate UUT
Adder1b uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout)
);
initial begin
    // Iterate through all input combinations
    A=0; B=0; Cin=0; #10;
    A=0; B=0; Cin=1; #10;
    A=0; B=1; Cin=0; #10;
    A=0; B=1; Cin=1; #10;
    A=1; B=0; Cin=0; #10;
    A=1; B=0; Cin=1; #10;
    A=1; B=1; Cin=0; #10;
    A=1; B=1; Cin=1; #10;

    $stop;
end
endmodule
```

获得的仿真波形如下：

#image("Adder1b_simulation.png")

通过仿真波形可以观察到，当输入信号 A、B、Cin 变化时，输出 S 与 Cout 能够及时响应，符合组合逻辑电路的特性。

具体分析可知，当输入中“1”的个数为奇数时，输出 S 为 1；当为偶数时，S 为 0，体现了异或运算的特性。同时，当输入中至少有两个“1”时，Cout 为 1，表示产生进位。例如在 A = 1，B = 1，Cin = 0 时，输出 S = 0，Cout = 1；在 A = 1，B = 1，Cin = 1 时，输出 S = 1，Cout = 1。仿真结果与理论分析完全一致，说明全加器设计正确。

== 四位加减法器仿真结果分析

首先，编写仿真文件`AddSub4b_tb.v`：
```verilog
`timescale 1ns / 1ps              
                                                                                                     
module AddSub4b_tb();

// Inputs
reg [3:0] A;
reg [3:0] B;
reg Ctrl;  // 0: ADD, 1: SUB

// Outputs
wire [3:0] S;
wire Cout;

// Instantiate UUT
AddSub4b uut (
    .A(A),
    .B(B),
    .Ctrl(Ctrl),
    .S(S),
    .Cout(Cout)
);

initial begin
    // =====================
    // Adder test (Ctrl = 0)
    // =====================
    Ctrl = 0;

    // Normal case
    A = 4'b0011; B = 4'b0101; #10; // 3 + 5

    // Boundary case: overflow
    A = 4'b1111; B = 4'b0001; #10; // 15 + 1

    // =====================
    // Subtractor test (Ctrl = 1)
    // =====================
    Ctrl = 1;

    // Normal case
    A = 4'b1000; B = 4'b0011; #10; // 8 - 3

    // Boundary case: borrow
    A = 4'b0000; B = 4'b0001; #10; // 0 - 1

    // Boundary case: zero result
    A = 4'b0110; B = 4'b0110; #10; // 6 - 6

    $stop;
end

endmodule
```

获得的仿真波形如下：

#image("AddSub4b_simulation.png")

在加法模式（Ctrl = 0）下，仿真结果表明电路能够正确完成四位二进制加法运算。例如在 A = 0011，B = 0101 时，输出 S = 1000，Cout = 0；在边界情况 A = 1111，B = 0001 时，输出 S = 0000，同时 Cout = 1，表明产生了进位溢出。

在减法模式（Ctrl = 1）下，电路能够正确实现减法功能。例如在 A = 1000，B = 0011 时，输出 S = 0101，符合 8 − 3 = 5；在边界情况 A = 0000，B = 0001 时，输出结果以补码形式表示，同时 Cout 反映借位情况；当 A 与 B 相等时，输出 S = 0000，验证了减法结果为零的正确性。

综上所述，仿真波形验证了四位加减法器在不同控制信号下均能正确执行加法与减法运算，并能够处理进位与借位等边界情况，说明电路设计满足实验要求。

= 第三部分：讨论与心得

没啥好说的，都很顺利。要是下次做实验能学会写verilog就好了。

= （666还有第二关）

= 第一部分：操作方法与实验步骤

本次实验的目标是将 ALU 模块集成到实验板上，并使用按键和开关控制，实现四位数数字的自增与 ALU 运算，同时在七段数码管上显示结果。主要步骤如下：

1. *模块准备*  
    - 导入并检查以下模块：
        - ALU.v（本次实验自行完成的四位 ALU）
        - Adder1b.v、AddSub4b.v（前期实验完成的加减法器）
        - CreateNumber.v、pbdebounce.v（实验指导提供）
        - DisplayNumber.v（Lab7 已完成）
        - clkdiv.v（Lab7 提供的时钟分频器）
        - Sseg_Dev.v、P2S_io.v、P2S.edf（附件提供的七段数码管静态显示模块）

2. *Top.v 修改与连接*  
    - 填写学号后四位到 `disp_hexs_my` 用于左侧四个数码管显示。  
    - 将 ALU 模块的输入连接到 CreateNumber 生成的数字：
        - `A` = num[3:0]  
        - `B` = num[7:4]  
        - `op` = SW2（操作码开关）  
    - 将 ALU 输出 `res` 和 `Cout` 对应连接到 DisplayNumber 显示。  
    - 确保 DisplayNumber 的 `.LEs` 与 `.rst` 正确连接：低电平有效，全使能；不复位。
    - 确保 Sseg_Dev、P2S_io、P2S.edf 文件类型正确（EDIF）并导入工程。

3. *按键去抖与数字自增*  
    - 使用 pbdebounce 对 BTN 信号去抖，每次按下按钮数字只增加一次。  
    - CreateNumber 模块根据按钮和开关状态对 num 输出进行自增/自减。

4. *仿真与下板测试*  
    - 对 ALU 输入和 CreateNumber 按键变化进行仿真，观察 `res` 与 `num` 的波形。  
    - 综合、实现并生成 Bitstream 下载至板子上，观察数码管显示效果。  

= 第二部分：实验结果与分析

1. *仿真波形观察*  
    - ALU 仿真显示四种操作（加法、减法、按位与、按位或）均能正常输出，边界情况（加法溢出、减法借位）正确处理。  
    - CreateNumber 在 BTN 按下时，数字按预期自增/自减，pbdebounce 有效防止数字跳动。  

    *实验波形截图：*  

#image("ALU_simulation.png", width: 80%)

2. *下板显示观察*  
    - 左侧四位七段数码管显示学号后四位数字。  
    - 右侧四位七段数码管显示 CreateNumber 输出及 ALU 结果。  
    - 按键 BTN 控制数字自增，SW1 控制加/减，SW2 控制 ALU 操作，显示与操作同步。  

    *实验板照片位置：*  

#grid(
  columns: 5,
  gutter: 0.2em,
  [
    #figure(
      image("26810000.jpg", width: 100%),
      caption: [26810000]
    )
  ],
  [
    #figure(
      image("26813306-add.jpg", width: 100%),
      caption: [26813306]
    )
  ],
  [
    #figure(
      image("26814307-or.jpg", width: 100%),
      caption: [26814307]
    )
  ],
  [
    #figure(
      image("26814300-and.jpg", width: 100%),
      caption: [26814300]
    )
  ],
  [
    #figure(
      image("26815702-subtract.jpg", width: 100%),
      caption: [26815702]
    )
  ]
)


= 第三部分：讨论与心得

本次实验有点上强度了，而且我一开始还用了一个错误的`MyMC14495.v`，各种疑惑让我浪费了很多时间。感觉做实验之前最好还是先搞清楚实验在干什么、项目文件结构是怎样、文件之间的关系是什么，etc.，而不是一上来就写代码拉电线。

= 附录：思考题

== 一、连续 8 个时钟正边沿 button 为高电位

- 输入：button 在连续 8 个时钟上升沿保持高电位  
- 模块工作原理：
    ```
    pbshift = pbshift << 1
    pbshift[0] = button
    if pbshift == 8'hFF: pbreg = 1
    if pbshift == 8'b0: pbreg = 0
    ```
- 分析：
    - 初始 pbshift 未说明，但假设之前输出 pbreg = 0，pbshift 不全为 1  
    - 每个时钟将 button 的 1 移入 pbshift  
    - 8 个时钟后 pbshift = 8'b11111111 → 条件成立 → pbreg = 1  
- 结论：*输出 pbreg 从 0 变为 1*，说明经过连续稳定高电平后输出才改变，实现去抖动功能。

== 二、连续 8 个时钟正边沿 button 为低电位

- 输入：button 在连续 8 个时钟上升沿保持低电位  
- 分析：
    - 每个时钟将 0 移入 pbshift  
    - 8 个时钟后 pbshift = 8'b00000000 → 条件成立 → pbreg = 0  
- 结论：*输出 pbreg 从 1 变为 0*（或保持 0），只有连续 8 个低电平后才改变，去除抖动引起的短暂波动。

== 三、图一时刻 8 过后的输出分析

#image("tp-1.png")

- 分析方法：
    1. 每个时钟正边沿将当前 button 值左移进入 pbshift  
    2. pbshift 累积 8 位连续值  
    3. 当 pbshift 全为 1 → pbreg 置 1  
       当 pbshift 全为 0 → pbreg 置 0
- 结论：根据图一，时刻 8 过后，pbshift 已连续 8 个高电平 → *输出 pbreg = 1*

== 四、图二时刻 8 过后的输出分析

#image("tp-2.png")

- 分析方法同上：
    - pbshift 在时刻 8 前未达到全 1 或全 0  
    - 因此 **输出 pbreg 保持原状态**  
- 结论：输出未变化，说明模块仅在输入稳定足够长时间后才改变输出，实现去抖动功能。