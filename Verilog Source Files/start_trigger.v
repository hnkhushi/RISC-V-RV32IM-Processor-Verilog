module start_trigger(clk, start, start_out, reset, done, busy);
input start, reset, done, clk, busy;
output start_out;

reg start_sent;
reg extend;   // holds pulse for 2nd cycle

wire trigger;

// same immediate detection as your original design
assign trigger = start & ~start_sent & ~busy;

// output is immediate OR extended
assign start_out = trigger | extend;

always @(posedge clk) begin
    if (reset || done) begin
        start_sent <= 1'b0;
        extend     <= 1'b0;
    end else begin
        // latch that we've seen the start
        if (start)
            start_sent <= 1'b1;
        else
            start_sent <= 1'b0;

        // extend pulse for one extra cycle
        extend <= trigger;
    end
end

endmodule