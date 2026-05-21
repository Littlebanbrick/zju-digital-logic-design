module clkdiv(
    clk,
    div_res,
    rst
);

    input clk;
    input rst;
    output reg [31:0] div_res;

    always @(posedge clk or posedge rst) begin
        if (rst)
            div_res <= 32'd0;
        else
            div_res <= div_res + 1'b1;
    end

endmodule
