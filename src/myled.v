module led (
    input sys_clk,          // clk input
    input sys_rst_n,        // reset input
    output reg [5:0] led    // 6 LEDS pin
);

`define counter_w 32
//`define TIME `counter_w'd1349_9999 // 0.5sec  
`define TIME `counter_w'd2700_0000 // 1sec
`define TIME_ZERO `counter_w'd0

reg [`counter_w-1:0] counter;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= `TIME_ZERO;
    else if (counter < `TIME)
        counter <= counter + 1'b1;
    else
        counter <= `TIME_ZERO;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        led <= 6'b111110;
    else if (counter == `TIME)
        led[5:0] <= {led[4:0],led[5]};
    else
        led <= led;
end

endmodule
