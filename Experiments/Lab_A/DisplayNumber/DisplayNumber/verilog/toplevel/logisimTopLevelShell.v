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
   wire [3:0]  s_LEs;
   wire [7:0]  s_SEGMENT;
   wire        s_clk;
   wire [15:0] s_hexs;
   wire [3:0]  s_points;
   wire        s_rst;

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
   assign s_clk       = 1'b0;
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
   assign s_rst       = 1'b0;

   /*******************************************************************************
   ** The toplevel component is connected here                                   **
   *******************************************************************************/
   DisplayNumber   CIRCUIT_0 (.AN(s_AN),
                              .LEs(s_LEs),
                              .SEGMENT(s_SEGMENT),
                              .clk(s_clk),
                              .hexs(s_hexs),
                              .points(s_points),
                              .rst(s_rst));
endmodule
