/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : ALU                                                          **
 **                                                                          **
 *****************************************************************************/

module ALU( A,
            B,
            Cout,
            op,
            res );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input [3:0] A;
   input [3:0] B;
   input [1:0] op;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output       Cout;
   output [3:0] res;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [3:0] s_logisimBus3;
   wire [1:0] s_logisimBus4;
   wire [3:0] s_logisimBus5;
   wire [3:0] s_logisimBus6;
   wire [3:0] s_logisimBus7;
   wire [3:0] s_logisimBus8;
   wire [3:0] s_logisimBus9;
   wire       s_logisimNet0;
   wire       s_logisimNet1;
   wire       s_logisimNet10;
   wire       s_logisimNet2;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus4[1:0] = op;
   assign s_logisimBus7[3:0] = B;
   assign s_logisimBus8[3:0] = A;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign Cout = s_logisimNet10;
   assign res  = s_logisimBus9[3:0];

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // Ground
   assign  s_logisimNet1  =  1'b0;


   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   AddSub4b   AddSub4b_inst (.A(s_logisimBus8[3:0]),
                             .B(s_logisimBus7[3:0]),
                             .Cout(s_logisimNet2),
                             .Ctrl(s_logisimBus4[0]),
                             .S(s_logisimBus3[3:0]));

   And2b4   And2b4_inst (.A(s_logisimBus8[3:0]),
                         .B(s_logisimBus7[3:0]),
                         .res(s_logisimBus6[3:0]));

   Or2b4   Or2b4_inst (.A(s_logisimBus8[3:0]),
                       .B(s_logisimBus7[3:0]),
                       .res(s_logisimBus5[3:0]));

   Mux4to1b4   Mux4to1b4_inst (.D0(s_logisimBus3[3:0]),
                               .D1(s_logisimBus3[3:0]),
                               .D2(s_logisimBus6[3:0]),
                               .D3(s_logisimBus5[3:0]),
                               .S(s_logisimBus4[1:0]),
                               .Y(s_logisimBus9[3:0]));

   Mux4to1   Mux4to1_inst (.D0(s_logisimNet2),
                           .D1(s_logisimNet2),
                           .D2(s_logisimNet1),
                           .D3(s_logisimNet1),
                           .S(s_logisimBus4[1:0]),
                           .Y(s_logisimNet10));

endmodule
