module score (
	input clk,
	input reset,
	inout hit,
	output [9:0] curr_score, 
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2, 
	output [6:0] HEX3 
	);

	hex_seg h0 (HEX0, ones);
	hex_seg h1 (HEX1, tens);
	hex_seg h2 (HEX2, hundreds);
	hex_seg h3 (HEX3, thousands);

	wire [3:0] ones;
	wire [3:0] tens;
	wire [3:0] hundreds;
	wire [3:0] thousands;
	
	always @ (posegde clk)
		begin
			if (reset) begin
				curr_score = 6'd0;
			end 
			else begin
				if (hit) begin
					if (ones < 4'b10)
						ones = ones + 1'b1;
					else if (tens < 4'b10)
					hit = 1'b0;
				end
		end

endmodule
