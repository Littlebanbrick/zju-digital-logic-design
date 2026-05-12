/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : AddSub4b                                                     **
 **                                                                          **
 *****************************************************************************/

module AddSub4b( A,
                 B,
                 Cout,
                 Ctrl,
                 S );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input [3:0] A;
   input [3:0] B;
   input       Ctrl;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output       Cout;
   output [3:0] S;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [3:0] s_logisimBus14;
   wire [3:0] s_logisimBus23;
   wire [3:0] s_logisimBus24;
   wire       s_logisimNet0;
   wire       s_logisimNet1;
   wire       s_logisimNet10;
   wire       s_logisimNet11;
   wire       s_logisimNet12;
   wire       s_logisimNet13;
   wire       s_logisimNet15;
   wire       s_logisimNet16;
   wire       s_logisimNet17;
   wire       s_logisimNet18;
   wire       s_logisimNet19;
   wire       s_logisimNet2;
   wire       s_logisimNet20;
   wire       s_logisimNet21;
   wire       s_logisimNet22;
   wire       s_logisimNet3;
   wire       s_logisimNet4;
   wire       s_logisimNet5;
   wire       s_logisimNet6;
   wire       s_logisimNet7;
   wire       s_logisimNet8;
   wire       s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus14[3:0] = A;
   assign s_logisimBus24[3:0] = B;
   assign s_logisimNet8       = Ctrl;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign Cout = s_logisimNet4;
   assign S    = s_logisimBus23[3:0];

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimBus24[2]),
               .input2(s_logisimNet8),
               .result(s_logisimNet11));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet18),
               .input2(s_logisimNet8),
               .result(s_logisimNet4));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimBus24[0]),
               .input2(s_logisimNet8),
               .result(s_logisimNet21));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimBus24[1]),
               .input2(s_logisimNet8),
               .result(s_logisimNet22));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimBus24[3]),
               .input2(s_logisimNet8),
               .result(s_logisimNet12));


   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   Adder1b   Adder2_inst (.A(s_logisimBus14[1]),
                          .B(s_logisimNet22),
                          .Cin(s_logisimNet6),
                          .Cout(s_logisimNet19),
                          .S(s_logisimBus23[1]));

   Adder1b   Adder1_inst (.A(s_logisimBus14[0]),
                          .B(s_logisimNet21),
                          .Cin(s_logisimNet8),
                          .Cout(s_logisimNet6),
                          .S(s_logisimBus23[0]));

   Adder1b   Adder4_inst (.A(s_logisimBus14[3]),
                          .B(s_logisimNet12),
                          .Cin(s_logisimNet13),
                          .Cout(s_logisimNet18),
                          .S(s_logisimBus23[3]));

   Adder1b   Adder3_inst (.A(s_logisimBus14[2]),
                          .B(s_logisimNet11),
                          .Cin(s_logisimNet19),
                          .Cout(s_logisimNet13),
                          .S(s_logisimBus23[2]));

endmodule
