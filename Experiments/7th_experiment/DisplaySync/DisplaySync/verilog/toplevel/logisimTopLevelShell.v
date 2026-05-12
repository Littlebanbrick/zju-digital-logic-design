/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : logisimTopLevelShell                                         **
 **                                                                          **
 *****************************************************************************/

module logisimTopLevelShell(  );

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire [3:0]  s_AN;
   wire [3:0]  s_HEX;
   wire        s_LE;
   wire [3:0]  s_LEs;
   wire [15:0] s_hexs;
   wire        s_point;
   wire [3:0]  s_points;
   wire [1:0]  s_scan;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** All signal adaptations are performed here                                  **
   *******************************************************************************/
   assign s_LEs[0]    = 1'b0;
   assign s_LEs[1]    = 1'b0;
   assign s_LEs[2]    = 1'b0;
   assign s_LEs[3]    = 1'b0;
   assign s_hexs[0]   = 1'b0;
   assign s_hexs[10]  = 1'b0;
   assign s_hexs[11]  = 1'b0;
   assign s_hexs[12]  = 1'b0;
   assign s_hexs[13]  = 1'b0;
   assign s_hexs[14]  = 1'b0;
   assign s_hexs[15]  = 1'b0;
   assign s_hexs[1]   = 1'b0;
   assign s_hexs[2]   = 1'b0;
   assign s_hexs[3]   = 1'b0;
   assign s_hexs[4]   = 1'b0;
   assign s_hexs[5]   = 1'b0;
   assign s_hexs[6]   = 1'b0;
   assign s_hexs[7]   = 1'b0;
   assign s_hexs[8]   = 1'b0;
   assign s_hexs[9]   = 1'b0;
   assign s_points[0] = 1'b0;
   assign s_points[1] = 1'b0;
   assign s_points[2] = 1'b0;
   assign s_points[3] = 1'b0;
   assign s_scan[0]   = 1'b0;
   assign s_scan[1]   = 1'b0;

   /*******************************************************************************
   ** The toplevel component is connected here                                   **
   *******************************************************************************/
   DisplaySync   CIRCUIT_0 (.AN(s_AN),
                            .HEX(s_HEX),
                            .LE(s_LE),
                            .LEs(s_LEs),
                            .hexs(s_hexs),
                            .point(s_point),
                            .points(s_points),
                            .scan(s_scan));
endmodule
