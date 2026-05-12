/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : main                                                         **
 **                                                                          **
 *****************************************************************************/

module main( Q,
             Qbar,
             R,
             S,
             clk,
             mid_Q,
             mid_Qbar );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input R;
   input S;
   input clk;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output Q;
   output Qbar;
   output mid_Q;
   output mid_Qbar;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire s_logisimNet0;
   wire s_logisimNet1;
   wire s_logisimNet10;
   wire s_logisimNet11;
   wire s_logisimNet12;
   wire s_logisimNet2;
   wire s_logisimNet3;
   wire s_logisimNet4;
   wire s_logisimNet5;
   wire s_logisimNet6;
   wire s_logisimNet7;
   wire s_logisimNet8;
   wire s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimNet10 = R;
   assign s_logisimNet5  = clk;
   assign s_logisimNet9  = S;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign Q        = s_logisimNet3;
   assign Qbar     = s_logisimNet4;
   assign mid_Q    = s_logisimNet0;
   assign mid_Qbar = s_logisimNet6;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet11 = ~s_logisimNet5;

   // NOT Gate
   assign s_logisimNet12 = ~s_logisimNet5;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   NAND_GATE #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet9),
               .input2(s_logisimNet5),
               .result(s_logisimNet1));

   NAND_GATE #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet5),
               .input2(s_logisimNet10),
               .result(s_logisimNet2));

   NAND_GATE #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet1),
               .input2(s_logisimNet6),
               .result(s_logisimNet0));

   NAND_GATE #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet0),
               .input2(s_logisimNet2),
               .result(s_logisimNet6));

   NAND_GATE #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet0),
               .input2(s_logisimNet11),
               .result(s_logisimNet8));

   NAND_GATE #(.BubblesMask(2'b00))
      GATES_6 (.input1(s_logisimNet6),
               .input2(s_logisimNet12),
               .result(s_logisimNet7));

   NAND_GATE #(.BubblesMask(2'b00))
      GATES_7 (.input1(s_logisimNet8),
               .input2(s_logisimNet4),
               .result(s_logisimNet3));

   NAND_GATE #(.BubblesMask(2'b00))
      GATES_8 (.input1(s_logisimNet3),
               .input2(s_logisimNet7),
               .result(s_logisimNet4));


endmodule
