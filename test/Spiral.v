`default_nettype none

module Spiral(input CLK_IN, output GLED5, output RLED1, output RLED2, output RLED3, output RLED4);
	reg [24:0] counter;
	reg [4:0] ledState;

	// Increment counter on each clock cycle
	always @(posedge CLK_IN) begin
		counter <= counter + 1;
		// We use counter as a clock divider to slow down the LED pattern.
		if (counter == 24'hffffff) begin
			counter <= 24'h000000;
			// Each cycle, light an additional LED.
			// If they're all lit, turn them all off to restart the pattern.
			if (ledState == 5'b11111)
				ledState <= 5'b00000;
			else
				ledState <= (ledState << 1) + 1;
		end
	end

	// LEDs will illuminate in a spiral, ending with the center green LED.
	assign RLED1 = ledState[0];
	assign RLED2 = ledState[1];
	assign RLED3 = ledState[2];
	assign RLED4 = ledState[3];
	assign GLED5 = ledState[4];

endmodule
