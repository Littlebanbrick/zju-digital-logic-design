// 100ms period (10Hz) clock divider
// Input clk is 100MHz, so divide by 10,000,000
module clk_100ms(
    input  clk,
    output reg clk_100ms
);
    reg [23:0] counter;  // 24-bit counter up to 9,999,999

    always @(posedge clk) begin
        if (counter == 4_999_999) begin        // half period = 50ms
            counter <= 24'd0;
            clk_100ms <= ~clk_100ms;           // toggle output
        end else begin
            counter <= counter + 1;
        end
    end

    initial begin
        counter = 24'd0;
        clk_100ms = 1'b0;
    end
endmodule