module temp_controlled_fan (

    input wire clk,          // Clock input (e.g., 50 MHz)
    input wire [7:0] temp,   // 8-bit temperature input

    output reg fan,          // PWM output to fan
    output reg [1:0] speed_level // 00=Off, 01=Low, 10=Med, 11=High

);

reg [7:0] pwm_counter = 0;
reg [7:0] duty_cycle = 0;

// Determine duty cycle based on temperature
always @(posedge clk) begin

    if (temp < 8'd30) begin
        duty_cycle <= 8'd0;      // Fan off
        speed_level <= 2'b00;
    end

    else if (temp < 8'd50) begin
        duty_cycle <= 8'd85;     // Low speed
        speed_level <= 2'b01;
    end

    else if (temp < 8'd70) begin
        duty_cycle <= 8'd170;    // Medium speed
        speed_level <= 2'b10;
    end

    else begin
        duty_cycle <= 8'd255;    // High speed
        speed_level <= 2'b11;
    end

end

// Simple PWM generator
always @(posedge clk) begin

    pwm_counter <= pwm_counter + 1;

    if (pwm_counter < duty_cycle)
        fan <= 1;
    else
        fan <= 0;

end

endmodule
