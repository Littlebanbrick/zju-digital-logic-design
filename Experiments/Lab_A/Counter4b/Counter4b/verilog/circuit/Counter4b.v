/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : Counter4b                                                    **
 **                                                                          **
 *****************************************************************************/

module Counter4b( Qa,
                  Qb,
                  Qc,
                  Qd,
                  Rc,
                  clk );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input clk;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output Qa;
   output Qb;
   output Qc;
   output Qd;
   output Rc;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire s_logisimNet0;
   wire s_logisimNet1;
   wire s_logisimNet10;
   wire s_logisimNet11;
   wire s_logisimNet12;
   wire s_logisimNet13;
   wire s_logisimNet14;
   wire s_logisimNet15;
   wire s_logisimNet16;
   wire s_logisimNet17;
   wire s_logisimNet18;
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
   assign s_logisimNet11 = clk;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign Qa = s_logisimNet4;
   assign Qb = s_logisimNet13;
   assign Qc = s_logisimNet5;
   assign Qd = s_logisimNet14;
   assign Rc = s_logisimNet15;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet16 = ~s_logisimNet8;

   // NOT Gate
   assign s_logisimNet1 = ~s_logisimNet9;

   // NOT Gate
   assign s_logisimNet12 = ~s_logisimNet18;

   // NOT Gate
   assign s_logisimNet2 = ~s_logisimNet10;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   NOR_GATE #(.BubblesMask(2'b00))
      GATES_1 (.input1(s_logisimNet8),
               .input2(s_logisimNet0),
               .result(s_logisimNet7));

   NOR_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_2 (.input1(s_logisimNet8),
               .input2(s_logisimNet6),
               .input3(s_logisimNet0),
               .result(s_logisimNet17));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_3 (.input1(s_logisimNet16),
               .input2(s_logisimNet0),
               .result(s_logisimNet9));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_4 (.input1(s_logisimNet7),
               .input2(s_logisimNet6),
               .result(s_logisimNet18));

   XOR_GATE_ONEHOT #(.BubblesMask(2'b00))
      GATES_5 (.input1(s_logisimNet17),
               .input2(s_logisimNet3),
               .result(s_logisimNet10));

   NOR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_6 (.input1(s_logisimNet3),
               .input2(s_logisimNet6),
               .input3(s_logisimNet0),
               .input4(s_logisimNet8),
               .result(s_logisimNet15));


   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   FD   FD0 (.D(s_logisimNet8),
             .Q(s_logisimNet4),
             .Qn(s_logisimNet8),
             .clk(s_logisimNet11));

   FD   FD1 (.D(s_logisimNet1),
             .Q(s_logisimNet13),
             .Qn(s_logisimNet0),
             .clk(s_logisimNet11));

   FD   FD2 (.D(s_logisimNet12),
             .Q(s_logisimNet5),
             .Qn(s_logisimNet6),
             .clk(s_logisimNet11));

   FD   FD3 (.D(s_logisimNet2),
             .Q(s_logisimNet14),
             .Qn(s_logisimNet3),
             .clk(s_logisimNet11));

endmodule
