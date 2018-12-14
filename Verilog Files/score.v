module score(
	input clk,
	input reset,
	input hit,
	//output [9:0] curr_score, 
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2, 
	output [6:0] HEX3 
	);

	reg [3:0] ones;
	reg [3:0] tens;
	reg [3:0] hundreds;
	reg [3:0] thousands;

	hex_seg h0 (HEX0, ones);
	hex_seg h1 (HEX1, tens);
	hex_seg h2 (HEX2, hundreds);
	hex_seg h3 (HEX3, thousands);
	
	always @ (posedge hit)
		begin
			if (reset) begin
				//curr_score = 9'd0;
				ones <= 4'd0;
				tens <= 4'd0;
				hundreds <= 4'd0;
				thousands <= 4'd0;
			end 
			else begin
				ones <= ones +1'b1;
					if (ones == 4'd10) begin
						ones <= 4'd0;
						tens <= tens + 1'b1;
						//hit <= 1'b0;
					end
					if (tens == 4'd10) begin
						tens <= 4'd0;
						hundreds <= hundreds + 1'b1;
					end
					if( hundreds == 4'd10) begin
						hundreds <= 4'd0;
						thousands <= thousands + 1'b1;
					end
					if(thousands == 4'd10) begin
						ones <= 4'd0;
						tens <= 4'd0;
						hundreds <= 4'd0;
						thousands <= 4'd0;
					end
			end
		end
		
		//always @(posedge ones) begin

endmodule

