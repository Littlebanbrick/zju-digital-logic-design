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
            cnt <= cnt + 1'b1;
        end else begin
            cnt <= cnt - 1'b1;
        end
    end

    assign Rc = (s == 1'b0 && cnt == 16'hFFFF) ||
                (s == 1'b1 && cnt == 16'h0000);

endmodule
