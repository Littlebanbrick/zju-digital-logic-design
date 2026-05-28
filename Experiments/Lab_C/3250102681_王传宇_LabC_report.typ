// English Report Template

// ===== Code Block Style Optimization =====

// 控制代码块外观（背景、边距）
// 只处理“代码块”
#show raw.where(block: true): set block(
  fill: luma(250),
  inset: 6pt,
  radius: 3pt,
)

#show raw.where(block: true): set text(
  size: 9pt,
  font: "Courier New",
)

#show raw.where(block: true): set par(
  leading: 1.15em,
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
    Lab C
    \
    Counter & Timer
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
  #text(size: 20pt)[时间：2026-5-28]
  #v(0.5em)
  #text(size: 20pt)[地点：紫金港东四509室]
]

#pagebreak()

// Main report starts here

= 第一部分：操作方法与实验步骤

= 第二部分：实验结果与分析

= 第三部分：讨论与心得

= 附录：
