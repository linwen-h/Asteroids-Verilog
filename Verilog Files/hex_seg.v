module hex_seg(display, score);
	input [4:0] score;
	output [6:0] display;

	decoder d(
		.c3(score[3]),
		.c2(score[2]),
		.c1(score[1]),
		.c0(score[0]),
		.s0(display[0]),
		.s1(display[1]),
		.s2(display[2]),
		.s3(display[3]),
		.s4(display[4]),
		.s5(display[5]),
		.s6(display[6])	
	);
endmodule

//submodule that assigns the off/on state for each segement s0 - s6
module decoder(c3,c2,c1,c0,s0,s1,s2,s3,s4,s5,s6);
	input c3, c2, c1, c0;
	output s0, s1, s2, s3, s4, s5, s6;
	
	assign s0 = (~c3&c2&~c1&~c0 | ~c3&~c2&~c1&c0 |
		c3&c2&~c1&c0 | c3&~c2&c1&c0);  
	
	assign s1 = (c3&c2&~c0 | ~c3&c2&~c1&c0 |
		c3&c1&c0 | c2&c1&~c0);

	assign s2 = (c3&c2&~c0 | c3&c2&c1 | ~c3&~c2&c1&~c0);
	
	assign s3 = (~c3&c2&~c1&~c0 | ~c3&~c2&~c1&c0 | 
		c2&c1&c0 | c3&~c2&c1&~c0);

	assign s4 = (~c3&c2&~c1 | ~c2&~c1&c0 | ~c3&c0);

	assign s5 = (c3&c2&~c1&c0 | ~c3&c1&c0 | 
		~c3&~c2&c1 | ~c3&~c2&c0);

	assign s6 = (~c3&~c2&~c1 | ~c3&c2&c1&c0 |
		c3&c2&~c1&~c0);
 
endmodule 
