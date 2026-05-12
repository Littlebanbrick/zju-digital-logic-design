/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : DisplaySync                                                  **
 **                                                                          **
 *****************************************************************************/

module DisplaySync( AN,
                    HEX,
                    LE,
                    LEs,
                    hexs,
                    point,
                    points,
                    scan );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input [3:0]  LEs;
   input [15:0] hexs;
   input [3:0]  points;
   input [1:0]  scan;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output [3:0] AN;
   output [3:0] HEX;
   output       LE;
   output       point;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [3:0]  s_logisimBus0;
   wire [3:0]  s_logisimBus1;
   wire [3:0]  s_logisimBus10;
   wire [3:0]  s_logisimBus11;
   wire [3:0]  s_logisimBus2;
   wire [3:0]  s_logisimBus3;
   wire [1:0]  s_logisimBus4;
   wire [3:0]  s_logisimBus5;
   wire [3:0]  s_logisimBus8;
   wire [15:0] s_logisimBus9;
   wire        s_logisimNet16;
   wire        s_logisimNet17;
   wire        s_logisimNet18;
   wire        s_logisimNet19;
   wire        s_logisimNet20;
   wire        s_logisimNet21;
   wire        s_logisimNet22;
   wire        s_logisimNet23;
   wire        s_logisimNet6;
   wire        s_logisimNet7;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus10[3:0] = points;
   assign s_logisimBus11[3:0] = LEs;
   assign s_logisimBus4[1:0]  = scan;
   assign s_logisimBus9[15:0] = hexs;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign AN    = s_logisimBus8[3:0];
   assign HEX   = s_logisimBus5[3:0];
   assign LE    = s_logisimNet7;
   assign point = s_logisimNet6;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // Constant
   assign  s_logisimBus0[3:0]  =  4'hE;


   // Constant
   assign  s_logisimBus1[3:0]  =  4'hD;


   // Constant
   assign  s_logisimBus2[3:0]  =  4'hB;


   // Constant
   assign  s_logisimBus3[3:0]  =  4'h7;


   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   Mux4to1b4   mux_AN (.D0(s_logisimBus0[3:0]),
                       .D1(s_logisimBus1[3:0]),
                       .D2(s_logisimBus2[3:0]),
                       .D3(s_logisimBus3[3:0]),
                       .S(s_logisimBus4[1:0]),
                       .Y(s_logisimBus8[3:0]));

   Mux4to1b4   mux_hexs (.D0(s_logisimBus9[3:0]),
                         .D1(s_logisimBus9[7:4]),
                         .D2(s_logisimBus9[11:8]),
                         .D3(s_logisimBus9[15:12]),
                         .S(s_logisimBus4[1:0]),
                         .Y(s_logisimBus5[3:0]));

   Mux4to1   mux_points (.D0(s_logisimBus10[0]),
                         .D1(s_logisimBus10[1]),
                         .D2(s_logisimBus10[2]),
                         .D3(s_logisimBus10[3]),
                         .S(s_logisimBus4[1:0]),
                         .Y(s_logisimNet6));

   Mux4to1   mux_LE (.D0(s_logisimBus11[0]),
                     .D1(s_logisimBus11[1]),
                     .D2(s_logisimBus11[2]),
                     .D3(s_logisimBus11[3]),
                     .S(s_logisimBus4[1:0]),
                     .Y(s_logisimNet7));

endmodule
