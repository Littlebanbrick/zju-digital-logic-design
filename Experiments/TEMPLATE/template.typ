// English Report Template

#set page(
  paper: "a4",
  margin: (left: 2.6cm, right: 2.6cm, top: 2.8cm, bottom: 2.8cm),
  numbering: "1",
  number-align: bottom + center,
  header: context [
    #text(size: 12pt, fill: gray.darken(25%))[FDS Report]
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
  #v(10%)
  #text(size: 40pt, weight: "bold")[REPORT TITLE]
  #image("icon_ZJU.png", width: 45%)
  #v(2em)
  #text(size: 20pt)[Author: __________]
  #v(0.5em)
  #text(size: 20pt)[Date: 2026-3-21]
]

#pagebreak()

// Main report starts here
= Chapter 1: Introduction
Problem description and (if any) background of the algorithms

= Chapter 2: Algorithm Specification
Description (pseudo-code preferred) of all the algorithms involved 
for solving the problem, including specifications of main data structures.

= Chapter 3: Testing Results
Table of test cases. Each test case usually consists of a brief 
description of the purpose of this case, the expected result, the actual 
behavior of your program, the possible cause of a bug if your program 
does not function as expected, and the current status (“pass”, or 
“corrected”, or “pending”).

= Chapter 4: Analysis and Comments
Analysis of the time and space complexities of the algorithms. 
Comments on further possible improvements.

= Appendix: Source Code (in C)
At least 30% of the lines must be commented. Otherwise the 
code will NOT be evaluated.

= Declaration
#text(size: 16pt)[#set par(first-line-indent: 2em)
  *_I hereby declare that all the work done in this project titled "XXX" is of my independent effort._*
]
