// clk_1s.v: 100 MHz -> 1 Hz clock divider
module clk_1s(
    input  clk,
    output reg clk_1s
);
    reg [25:0] cnt; // 50,000,000 -> half period
    always @(posedge clk) begin
        if (cnt == 49_999_999) begin
            cnt <= 0;
            clk_1s <= ~clk_1s;
        end else begin
            cnt <= cnt + 1;
        end
    end
    initial begin
        cnt = 0;
        clk_1s = 0;
    end
endmodule