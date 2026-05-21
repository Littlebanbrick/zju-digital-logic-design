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
    Lab B
    \
     Register
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
  #text(size: 20pt)[时间：2026-5-21]
  #v(0.5em)
  #text(size: 20pt)[地点：紫金港东四509室]
]

#pagebreak()

// Main report starts here

= 第一部分：操作方法与实验步骤

== 补全 Top 模块代码

根据实验要求，在给定的 `Top.v` 框架中补全多路选择与寄存器加载逻辑，完整代码如下：

```verilog
module Top(
    input clk,
    input BTNX4Y0,
    input BTNX4Y1,
    input BTNX4Y2,
    input [15:0] SW,
    output BTN_X,
    output[3:0]AN,
    output[7:0] SEGMENT
);

    wire [31:0] my_clkdiv;
    wire [2:0] btn_out;
    reg  [11:0] num;
    wire [3:0] A1, A2, B1, B2, C1, C2; // C1 maybe useless
    wire [3:0] mux_out;
    wire Co;
    wire [3:0] ALU_res;

    /* SW[1:0] to control if the counter for A or B is reversal */
    wire A_Ctrl = SW[0];
    wire B_Ctrl = SW[1];
    /* SW[3:2] to choose the mode of the ALU */
    wire [1:0] ALU_Ctrl = SW[3:2];
    /* SW[5:4] to choose from A B C and 0 */
    /* 00 for A; 01 for B; 10 for C; 11 for 0 */
    wire [1:0] Trans_select = SW[5:4];

    wire [3:0] reg_A_val = num[ 3: 0];
    wire [3:0] reg_B_val = num[ 7: 4];
    wire [3:0] reg_C_val = num[11: 8];

    assign BTN_X = 1'b0;

    clkdiv m0(.clk(clk), .rst(1'b0), .div_res(my_clkdiv));

    pbdebounce m1(.clk(my_clkdiv[17]), .button(BTNX4Y0), .pbreg(btn_out[0]));
    pbdebounce m2(.clk(my_clkdiv[17]), .button(BTNX4Y1), .pbreg(btn_out[1]));
    pbdebounce m3(.clk(my_clkdiv[17]), .button(BTNX4Y2), .pbreg(btn_out[2]));

    AddSub4b m4(.A(reg_A_val), .B(4'b0001), .Ctrl(A_Ctrl), .S(A1));
    AddSub4b m5(.A(reg_B_val), .B(4'b0001), .Ctrl(B_Ctrl), .S(B1));

    Mux4to1b4 m6(.D0(reg_A_val), .D1(reg_B_val), .D2(reg_C_val), .D3(4'b0000),
                                    .S(Trans_select), .Y(mux_out));

    /* ALU module implemented in Lab8 */
    /* A/B    : operands */
    /* S        : select the operation on ALU  */
    /* C         : result of ALU */
    /* Co        : Carry bit */
    ALU m7(.A(reg_A_val), .B(reg_B_val), .res(ALU_res), .Cout(Co), .op(ALU_Ctrl)); // (Co) may be useless

    DisplayNumber m8(.clk(clk), .hexs({reg_A_val, reg_B_val, ALU_res, reg_C_val}), 
                            .LEs(4'b0000), .points(4'b0000), .rst(1'b0), .AN(AN),
                            .SEGMENT(SEGMENT));

    /* Your code here */
    // SW[15]: 0 for ALU mode, 1 for Trans mode.
    assign A2 = (SW[15] == 1'b0) ? A1 : mux_out; 
    assign B2 = (SW[15] == 1'b0) ? B1 : mux_out;
    assign C2 = (SW[15] == 1'b0) ? ALU_res : mux_out;

    always @(posedge btn_out[0]) num[3:0] <= A2;
    always @(posedge btn_out[1]) num[7:4] <= B2;
    always @(posedge btn_out[2]) num[11:8] <= C2;
    /******************/

endmodule
```

== 代码分析

1. **模式选择**  
   利用 `SW[15]` 控制数据通路。`SW[15]=0` 时，寄存器更新值来自 `AddSub4b`（A、B 自增/自减结果）或 `ALU`（运算结果）；`SW[15]=1` 时，三路均来自 `Mux4to1b4` 的输出，实现总线传输。

2. **寄存器更新机制**  
   三个寄存器（`num` 的 4 位段）由按键消抖后的信号 `btn_out` 的上升沿触发加载。`assign A2/B2/C2` 组合逻辑给出待写入的值，`always @(posedge ...)` 实现同步加载，等价于带使能的寄存器。

3. **运算与传输控制**  
   - `SW[0]`、`SW[1]` 分别控制 A、B 的增/减，经 `AddSub4b` 产生 `A1`、`B1`。  
   - `SW[3:2]` 选择 `ALU` 的运算类型，结果 `ALU_res` 直接送数码管显示并可在 `SW[15]=0` 时写入 C。  
   - `SW[5:4]` 在传输模式下选择数据源（A / B / C / 0），经 `Mux4to1b4` 输出至 `mux_out`，三个寄存器共享同一总线。

4. **数码管显示**  
   模块 `DisplayNumber` 同时显示 A、B、ALU 结果和 C，便于实时观察。

= 第二部分：实验结果与分析

== ALU 运算模式（SW[15]=0）

=== 加法运算：4 + 6 = A

- 计算结果已出现在数码管第三位（A），但尚未保存到 C：
#figure(image("4+6=A_unsynced.jpg", width: 45%), caption: [未同步，显示 46A0])

- 按下 btn[2] 后，C 更新为 A：
#figure(image("4+6=A_synced.jpg", width: 45%), caption: [已同步，显示 46AA])

分析：`A=4, B=6`，ALU 正确计算出 `4+6=10`（十六进制 A），且只有按下对应按键后结果才写入 C，符合“Load 控制”要求。

=== 减法运算：4 - 6 = E

- 未保存前，结果位显示 E，C 保持原值：
#figure(image("4-6=E_unsynced.jpg", width: 45%), caption: [未同步，显示 46E6])

- 按下 btn[2] 后 C 更新为 E：
#figure(image("4-6=E_synced.jpg", width: 45%), caption: [已同步，显示 46EE])

分析：减法采用补码运算，`4-6 = -2`，四位补码表示为 `1110`（E），结果正确。

=== 按位与运算：4 AND 6 = 4

- 未同步：
#figure(image("4and6=4_unsynced.jpg", width: 45%), caption: [未同步，显示 464E])

- 已同步：
#figure(image("4and6=4_synced.jpg", width: 45%), caption: [已同步，显示 4644])

分析：`0100 & 0110 = 0100`，结果为 4，符合预期。

=== 按位或运算：4 OR 6 = 6

- 未同步：
#figure(image("4or6=6_unsynced.jpg", width: 45%), caption: [未同步，显示 466A])

- 已同步：
#figure(image("4or6=6_synced.jpg", width: 45%), caption: [已同步，显示 4666])

分析：`0100 | 0110 = 0110`，结果为 6，正确。

== 数据传输模式（SW[15]=1）

=== 同步 A（SW[5:4]=00）

- 初始状态：A=4, B=2, C=0，总线已选择 A 的值（C）：
#figure(image("syncingA_init.jpg", width: 45%), caption: [初始，显示 C400])

- 按下 btn[1] 将 B 更新为总线上的值（C）：
#figure(image("syncingA_B.jpg", width: 45%), caption: [同步 B，显示 CC80])

- 按下 btn[2] 将 C 也更新为 C：
#figure(image("syncingA_BandC.jpg", width: 45%), caption: [同步 C，显示 CC8C])

分析：`SW[5:4]=00` 选择 A，按键依次将总线值（4）写入 B 和 C，实现了寄存器间的数据传输。

=== 同步常数 0（SW[5:4]=11）

- 初始：A=0, B=C, C=C，总线已选择 0：
#figure(image("syncing0_A.jpg", width: 45%), caption: [初始，显示 0CCC])

- 按下 btn[1] 将 B 清零：
#figure(image("syncing0_AandB.jpg", width: 45%), caption: [同步 B，显示 000C])

- 按下 btn[2] 将 C 也清零：
#figure(image("syncing0_ABandC.jpg", width: 45%), caption: [同步 C，显示 0000])

分析：选择常数 0 后，按键将 0 依次写入 B 和 C，最终全部清零，功能正确。

\

== 总结

下板测试表明，两种模式下寄存器均能正确响应按键加载信号，ALU 运算结果与数据传输行为完全符合设计规格，数码管显示稳定，无竞争或时序问题。

= 第三部分：讨论与心得

无。

= 附录：约束文件

```xdc
# Filename: constraints_labB.xdc
# Constraints file for LabB (Register & ALU experiment)

# ---- Main clock (100 MHz) ----
set_property PACKAGE_PIN AC18 [get_ports clk]
set_property IOSTANDARD LVCMOS18 [get_ports clk]
create_clock -period 10.000 -name clk [get_ports clk]

# ---- BTN_X (output, driven LOW -> matrix keyboard row 4 W16) ----
set_property PACKAGE_PIN W16 [get_ports BTN_X]
set_property IOSTANDARD LVCMOS18 [get_ports BTN_X]

# ---- Push buttons (BTNX4Y[2:0], matrix column inputs) ----
set_property PACKAGE_PIN V18 [get_ports BTNX4Y0]
set_property PACKAGE_PIN V19 [get_ports BTNX4Y1]
set_property PACKAGE_PIN V14 [get_ports BTNX4Y2]
set_property IOSTANDARD LVCMOS18 [get_ports BTNX4Y0]
set_property IOSTANDARD LVCMOS18 [get_ports BTNX4Y1]
set_property IOSTANDARD LVCMOS18 [get_ports BTNX4Y2]
set_property PULLUP TRUE [get_ports BTNX4Y0]
set_property PULLUP TRUE [get_ports BTNX4Y1]
set_property PULLUP TRUE [get_ports BTNX4Y2]

# ---- Slide switches (SW[15:0], left-to-right order) ----
set_property PACKAGE_PIN AF10 [get_ports {SW[0]}]
set_property PACKAGE_PIN AF13 [get_ports {SW[1]}]
set_property PACKAGE_PIN AE13 [get_ports {SW[2]}]
set_property PACKAGE_PIN AF8  [get_ports {SW[3]}]
set_property PACKAGE_PIN AE8  [get_ports {SW[4]}]
set_property PACKAGE_PIN AF12 [get_ports {SW[5]}]
set_property PACKAGE_PIN AE12 [get_ports {SW[6]}]
set_property PACKAGE_PIN AE10 [get_ports {SW[7]}]
set_property PACKAGE_PIN AD10 [get_ports {SW[8]}]
set_property PACKAGE_PIN AD11 [get_ports {SW[9]}]
set_property PACKAGE_PIN Y12  [get_ports {SW[10]}]
set_property PACKAGE_PIN Y13  [get_ports {SW[11]}]
set_property PACKAGE_PIN AA12 [get_ports {SW[12]}]
set_property PACKAGE_PIN AA13 [get_ports {SW[13]}]
set_property PACKAGE_PIN AB10 [get_ports {SW[14]}]
set_property PACKAGE_PIN AA10 [get_ports {SW[15]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[4]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[5]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[6]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[7]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[8]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[9]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[10]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[11]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[12]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[13]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[14]}]
set_property IOSTANDARD LVCMOS15 [get_ports {SW[15]}]

# ---- 7-segment display ----
# Anodes (AN[3:0])
set_property PACKAGE_PIN AC22 [get_ports {AN[3]}]   ;
set_property PACKAGE_PIN AB21 [get_ports {AN[2]}]   ;
set_property PACKAGE_PIN AC21 [get_ports {AN[1]}]   ;
set_property PACKAGE_PIN AD21 [get_ports {AN[0]}]   ;
set_property IOSTANDARD LVCMOS33 [get_ports {AN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {AN[3]}]

# Segments (SEGMENT[7:0])
set_property PACKAGE_PIN AB22 [get_ports {SEGMENT[0]}]   ;# a
set_property PACKAGE_PIN AD24 [get_ports {SEGMENT[1]}]   ;# b
set_property PACKAGE_PIN AD23 [get_ports {SEGMENT[2]}]   ;# c
set_property PACKAGE_PIN Y21  [get_ports {SEGMENT[3]}]   ;# d
set_property PACKAGE_PIN W20  [get_ports {SEGMENT[4]}]   ;# e
set_property PACKAGE_PIN AC24 [get_ports {SEGMENT[5]}]   ;# f
set_property PACKAGE_PIN AC23 [get_ports {SEGMENT[6]}]   ;# g
set_property PACKAGE_PIN AA22 [get_ports {SEGMENT[7]}]   ;# dp
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SEGMENT[7]}]
```