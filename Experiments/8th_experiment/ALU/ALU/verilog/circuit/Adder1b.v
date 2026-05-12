/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : Adder1b                                                      **
 **                                                                          **
 *****************************************************************************/

module Adder1b( A,
                B,
                Cin,
                Cout,
                S );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input A;
   input B;
   input Cin;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output Cout;
   output S;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire s_logisimNet0;
   wire s_logisimNet1;
   wire s_logisimNet2;
   wire s_logisimNet3;
   wire s_logisimNet4;
   wire s_logisimNet5;
   wire s_logisimNet6;
   wire s_logisimNet7;
   wire s_logisimNet8;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimNet0 = A;
   assign s_logisimNet3 = Cin;
   assign s_logisimNet4 = B;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign Cout = s_logisimNet5;
   assign S    = s_logisimNet7;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet8),
               .input2(s_logisimNet3),
               .result(s_logisimNet7));

   XOR_GATE_3_INPUTS_ONEHOT #(.BubblesMask(3'b000))
      GATES_2 (.input1(s_logisimNet1),
               .input2(s_logisimNet6),
               .input3(s_logisimNet2),
               .result(s_logisimNet5));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet0),
               .input2(s_logisimNet4),
               .result(s_logisimNet8));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet4),
               .input2(s_logisimNet3),
               .result(s_logisimNet6));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet0),
               .input2(s_logisimNet4),
               .result(s_logisimNet1));

   AND_GATE #(.BubblesMask(2'b00))
      GATES_6 (.input1(s_logisimNet0),
               .input2(s_logisimNet3),
               .result(s_logisimNet2));


endmodule
