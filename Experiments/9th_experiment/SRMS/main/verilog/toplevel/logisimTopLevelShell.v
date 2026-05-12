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
   wire s_Q;
   wire s_Qbar;
   wire s_R;
   wire s_S;
   wire s_clk;
   wire s_mid_Q;
   wire s_mid_Qbar;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** All signal adaptations are performed here                                  **
   *******************************************************************************/
   assign s_R   = 1'b0;
   assign s_S   = 1'b0;
   assign s_clk = 1'b0;

   /*******************************************************************************
   ** The toplevel component is connected here                                   **
   *******************************************************************************/
   main   CIRCUIT_0 (.Q(s_Q),
                     .Qbar(s_Qbar),
                     .R(s_R),
                     .S(s_S),
                     .clk(s_clk),
                     .mid_Q(s_mid_Q),
                     .mid_Qbar(s_mid_Qbar));
endmodule
