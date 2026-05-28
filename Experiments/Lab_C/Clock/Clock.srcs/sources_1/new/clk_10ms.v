// 10ms period (100Hz) clock divider
// Input clk is 100MHz, so divide by 1,000,000
module clk_10ms(
    input  clk,
    output reg clk_10ms
);
    reg [19:0] counter;  // 20-bit counter up to 999,999

    always @(posedge clk) begin
        if (counter == 499_999) begin          // half period = 5ms
            counter <= 20'd0;
            clk_10ms <= ~clk_10ms;             // toggle output
        end else begin
            counter <= counter + 1;
        end
    end

    initial begin
        counter = 20'd0;
        clk_10ms = 1'b0;
    end
endmodule