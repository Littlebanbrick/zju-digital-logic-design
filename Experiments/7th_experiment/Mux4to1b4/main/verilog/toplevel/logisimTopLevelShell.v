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
   wire [3:0] s_D0;
   wire [3:0] s_D1;
   wire [3:0] s_D2;
   wire [3:0] s_D3;
   wire [1:0] s_S;
   wire [3:0] s_Y;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** All signal adaptations are performed here                                  **
   *******************************************************************************/
   assign s_D0[0] = 1'b0;
   assign s_D0[1] = 1'b0;
   assign s_D0[2] = 1'b0;
   assign s_D0[3] = 1'b0;
   assign s_D1[0] = 1'b0;
   assign s_D1[1] = 1'b0;
   assign s_D1[2] = 1'b0;
   assign s_D1[3] = 1'b0;
   assign s_D2[0] = 1'b0;
   assign s_D2[1] = 1'b0;
   assign s_D2[2] = 1'b0;
   assign s_D2[3] = 1'b0;
   assign s_D3[0] = 1'b0;
   assign s_D3[1] = 1'b0;
   assign s_D3[2] = 1'b0;
   assign s_D3[3] = 1'b0;
   assign s_S[0]  = 1'b0;
   assign s_S[1]  = 1'b0;

   /*******************************************************************************
   ** The toplevel component is connected here                                   **
   *******************************************************************************/
   main   CIRCUIT_0 (.D0(s_D0),
                     .D1(s_D1),
                     .D2(s_D2),
                     .D3(s_D3),
                     .S(s_S),
                     .Y(s_Y));
endmodule
