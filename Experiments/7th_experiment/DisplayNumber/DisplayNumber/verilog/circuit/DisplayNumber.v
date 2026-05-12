/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : DisplayNumber                                                **
 **                                                                          **
 *****************************************************************************/

module DisplayNumber( AN,
                      LEs,
                      SEGMENT,
                      clk,
                      hexs,
                      points,
                      rst );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input [3:0]  LEs;
   input        clk;
   input [15:0] hexs;
   input [3:0]  points;
   input        rst;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output [3:0] AN;
   output [7:0] SEGMENT;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [7:0]  s_logisimBus13;
   wire [15:0] s_logisimBus15;
   wire [3:0]  s_logisimBus16;
   wire [3:0]  s_logisimBus17;
   wire [31:0] s_logisimBus22;
   wire [3:0]  s_logisimBus23;
   wire [3:0]  s_logisimBus7;
   wire        s_logisimNet0;
   wire        s_logisimNet1;
   wire        s_logisimNet10;
   wire        s_logisimNet11;
   wire        s_logisimNet12;
   wire        s_logisimNet18;
   wire        s_logisimNet19;
   wire        s_logisimNet2;
   wire        s_logisimNet20;
   wire        s_logisimNet21;
   wire        s_logisimNet3;
   wire        s_logisimNet4;
   wire        s_logisimNet5;
   wire        s_logisimNet6;
   wire        s_logisimNet8;
   wire        s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimBus15[15:0] = hexs;
   assign s_logisimBus16[3:0]  = points;
   assign s_logisimBus17[3:0]  = LEs;
   assign s_logisimNet8        = rst;
   assign s_logisimNet9        = clk;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign AN      = s_logisimBus7[3:0];
   assign SEGMENT = s_logisimBus13[7:0];

   /*******************************************************************************
   ** Here all sub-circuits are defined                                          **
   *******************************************************************************/

   MyMC14495   MyMC14495_inst (.D0(s_logisimBus23[0]),
                               .D1(s_logisimBus23[1]),
                               .D2(s_logisimBus23[2]),
                               .D3(s_logisimBus23[3]),
                               .LE(s_logisimNet11),
                               .a(s_logisimBus13[0]),
                               .b(s_logisimBus13[1]),
                               .c(s_logisimBus13[2]),
                               .d(s_logisimBus13[3]),
                               .e(s_logisimBus13[4]),
                               .f(s_logisimBus13[5]),
                               .g(s_logisimBus13[6]),
                               .p(s_logisimBus13[7]),
                               .point(s_logisimNet10));

   clkdiv   clkdiv_inst (.clk(s_logisimNet9),
                         .div_res(s_logisimBus22[31:0]),
                         .rst(s_logisimNet8));

   DisplaySync   sync_inst (.AN(s_logisimBus7[3:0]),
                            .HEX(s_logisimBus23[3:0]),
                            .LE(s_logisimNet11),
                            .LEs(s_logisimBus17[3:0]),
                            .hexs(s_logisimBus15[15:0]),
                            .point(s_logisimNet10),
                            .points(s_logisimBus16[3:0]),
                            .scan(s_logisimBus22[18:17]));

endmodule
