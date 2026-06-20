module ShiftReg8b(
    input       clk,
    input       shiftn_loadp,   // 0: shift right, 1: parallel load
    input       shift_in,       // serial data input for shifting
    input [7:0] par_in,         // 8-bit parallel data input
    output[7:0] Q               // current state output
);

    reg [7:0] shift_reg;        // internal 8-bit register

    // Synchronous operation on rising edge of clk
    always @(posedge clk) begin
        if (shiftn_loadp)       // parallel load mode
            shift_reg <= par_in;
        else                    // shift right mode
            shift_reg <= {shift_in, shift_reg[7:1]};
    end

    assign Q = shift_reg;       // output the current state

endmodule