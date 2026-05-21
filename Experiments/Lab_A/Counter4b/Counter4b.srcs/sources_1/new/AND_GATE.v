module AND_GATE( input1, input2, result );

   parameter [64:0] BubblesMask = 1;

   input input1;
   input input2;

   output result;

   wire s_realInput1;
   wire s_realInput2;

   assign  s_realInput1 = (BubblesMask[0] == 1'b0) ? input1 : ~input1;
   assign  s_realInput2 = (BubblesMask[1] == 1'b0) ? input2 : ~input2;

   assign result = s_realInput1 & s_realInput2;

endmodule
