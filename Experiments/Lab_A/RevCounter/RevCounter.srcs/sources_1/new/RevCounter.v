module RevCounter( 
    input wire clk,
    input wire rst,
    input wire s,
    output reg [15:0] cnt = 0,
    output wire Rc
);

    always @(posedge clk) begin
        if (rst) begin
            cnt <= 16'd0;
        end else if (s == 1'b0) begin
            cnt <= cnt + 1'b1;          // 自增，16'hFFFF 自动回绕至 16'h0
        end else begin
            cnt <= cnt - 1'b1;          // 自减，16'h0 自动回绕至 16'hFFFF
        end
    end

    // 组合逻辑输出进位/借位信号
    assign Rc = (s == 1'b0 && cnt == 16'hFFFF) ||
                (s == 1'b1 && cnt == 16'h0000);

endmodule