/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : application                                                  **
 **                                                                          **
 *****************************************************************************/

module application( I0,
                    I1,
                    I2,
                    res );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input I0;
   input I1;
   input I2;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output res;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [7:0] s_logisimBus12;
   wire       s_logisimNet0;
   wire       s_logisimNet1;
   wire       s_logisimNet10;
   wire       s_logisimNet11;
   wire       s_logisimNet2;
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
   assign s_logisimNet3 = I0;
   assign s_logisimNet4 = I1;
   assign s_logisimNet5 = I2;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign res = s_logisimNet11;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // Power
   assign  s_logisimNet8  =  1'b1;


   // Ground
   assign  s_logisimNet7  =  1'b0;


   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   NAND_GATE_6_INPUTS #(.BubblesMask({2'b00, 4'h0}))
      GATES_1 (.input1(s_logisimBus12[0]),
               .input2(s_logisimBus12[2]),
               .input3(s_logisimBus12[4]),
               .input4(s_logisimBus12[5]),
               .input5(s_logisimBus12[6]),
               .input6(s_logisimBus12[7]),
               .result(s_logisimNet11));


   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   D_74LS138   m0 (.A(s_logisimNet3),
                   .B(s_logisimNet4),
                   .C(s_logisimNet5),
                   .G(s_logisimNet8),
                   .G2A(s_logisimNet7),
                   .G2B(s_logisimNet7),
                   .Y(s_logisimBus12[7:0]));

endmodule
