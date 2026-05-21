module DisplaySync( AN, HEX, LE, LEs, hexs, point, points, scan );

   input [3:0]  LEs;
   input [15:0] hexs;
   input [3:0]  points;
   input [1:0]  scan;

   output [3:0] AN;
   output [3:0] HEX;
   output       LE;
   output       point;

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
   wire        s_logisimNet6;
   wire        s_logisimNet7;

   assign s_logisimBus10[3:0] = points;
   assign s_logisimBus11[3:0] = LEs;
   assign s_logisimBus4[1:0]  = scan;
   assign s_logisimBus9[15:0] = hexs;

   assign AN    = s_logisimBus8[3:0];
   assign HEX   = s_logisimBus5[3:0];
   assign LE    = s_logisimNet7;
   assign point = s_logisimNet6;

   // AN values for each digit (active-low)
   assign  s_logisimBus0[3:0]  =  4'hE;  // digit 0: 1110
   assign  s_logisimBus1[3:0]  =  4'hD;  // digit 1: 1101
   assign  s_logisimBus2[3:0]  =  4'hB;  // digit 2: 1011
   assign  s_logisimBus3[3:0]  =  4'h7;  // digit 3: 0111

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
