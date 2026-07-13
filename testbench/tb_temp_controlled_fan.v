`timescale 1ns / 1ps

module tb_temp_controlled_fan;

reg clk;
reg [7:0] temp;
wire fan;
wire [1:0] speed_level;

// Instantiate the DUT (Device Under Test)
temp_controlled_fan uut (
    .clk(clk),
    .temp(temp),
    .fan(fan),
    .speed_level(speed_level)
);

// Generate clock: 20ns period = 50 MHz
initial
    clk = 0;

always #10 clk = ~clk;

// Apply different temperature values
initial begin
    $display("Time\tTemp\tFan\tSpeed");
    $monitor("%0t\t%d\t%b\t%b", $time, temp, fan, speed_level);

    temp = 8'd20; #2000; // Off
    temp = 8'd35; #2000; // Low
    temp = 8'd55; #2000; // Medium
    temp = 8'd80; #2000; // High
    temp = 8'd25; #2000; // Off again

    $stop;
end

endmodule
