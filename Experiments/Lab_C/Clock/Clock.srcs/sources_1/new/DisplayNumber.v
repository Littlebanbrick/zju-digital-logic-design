module DisplayNumber(
    input  wire       clk,
    input  wire       rst,          // synchronous reset, active high
    input  wire [15:0] hexs,        // 4 digits, each 4 bits: {digit3, digit2, digit1, digit0}
    input  wire [3:0]  points,      // decimal point control, 1 = light
    input  wire [3:0]  LEs,         // latch enable (low active), not used here
    output reg  [3:0]  AN,          // anode select, low active
    output reg  [7:0]  SEGMENT      // segment outputs, SEGMENT[7]=DP
);

    // Internal scan clock (about 1kHz from 100MHz)
    reg [16:0] scan_cnt;
    always @(posedge clk or posedge rst) begin
        if (rst)
            scan_cnt <= 17'd0;
        else
            scan_cnt <= scan_cnt + 1;
    end

    // Scan state: select which digit to drive (0~3)
    wire [1:0] scan_sel = scan_cnt[16:15]; // upper bits toggles slowly

    // Current digit data
    reg [3:0] current_hex;
    reg       current_point;
    always @* begin
        case (scan_sel)
            2'b00: begin
                current_hex   = hexs[3:0];   // rightmost digit (min_ones)
                current_point = points[0];
            end
            2'b01: begin
                current_hex   = hexs[7:4];   // min_tens
                current_point = points[1];
            end
            2'b10: begin
                current_hex   = hexs[11:8];  // hour_ones
                current_point = points[2];
            end
            2'b11: begin
                current_hex   = hexs[15:12]; // hour_tens
                current_point = points[3];
            end
            default: begin
                current_hex   = 4'b0;
                current_point = 1'b0;
            end
        endcase
    end

    // Anode control (low active) - enable only the selected digit
    always @* begin
        AN = 4'b1111;               // all off
        AN[scan_sel] = 1'b0;
    end

    reg [6:0] seg_low; // {g,f,e,d,c,b,a}
    always @* begin
        case (current_hex)
            4'h0: seg_low = 7'b1000000; // 0
            4'h1: seg_low = 7'b1111001; // 1
            4'h2: seg_low = 7'b0100100; // 2
            4'h3: seg_low = 7'b0110000; // 3
            4'h4: seg_low = 7'b0011001; // 4
            4'h5: seg_low = 7'b0010010; // 5
            4'h6: seg_low = 7'b0000010; // 6
            4'h7: seg_low = 7'b1111000; // 7
            4'h8: seg_low = 7'b0000000; // 8
            4'h9: seg_low = 7'b0010000; // 9
            4'hA: seg_low = 7'b0001000; // A
            4'hB: seg_low = 7'b0000011; // b
            4'hC: seg_low = 7'b1000110; // C
            4'hD: seg_low = 7'b0100001; // d
            4'hE: seg_low = 7'b0000110; // E
            4'hF: seg_low = 7'b0001110; // F
            default: seg_low = 7'b1111111;
        endcase
    end

    // Combine segments and decimal point (active low for dp as well)
    // SEGMENT = {dp, g, f, e, d, c, b, a}
    always @* begin
        SEGMENT = {~current_point, seg_low}; // dp is lit when current_point=1, so output 0
    end

endmodule