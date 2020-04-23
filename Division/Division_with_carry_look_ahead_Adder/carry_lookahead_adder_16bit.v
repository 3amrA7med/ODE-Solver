module carry_lookahead_adder_16bit(sub, in0, in1, cin, sum, cout, v);

	input [15:0] in0, in1;
	input cin;
	input sub;
	output [15:0] sum;
	output cout;
	output v;
	wire c1,c2,c3;
	wire v1,v2,v3;
	wire tempcin;
	wire [15:0] tempin1;

	assign tempcin = cin | sub;
	assign tempin1 = (sub)? (in1 ^ 16'b1111111111111111) : in1;
	 
	carry_lookahead_adder_4bit cla0 (in0[3:0], tempin1[3:0], tempcin, sum[3:0], c1, v1);
	carry_lookahead_adder_4bit cla1 (in0[7:4], tempin1[7:4], c1, sum[7:4], c2, v2);
	carry_lookahead_adder_4bit cla2 (in0[11:8], tempin1[11:8], c2, sum[11:8], c3, v3);
	carry_lookahead_adder_4bit cla3 (in0[15:12], tempin1[15:12], c3, sum[15:12], c4, v4);
 
endmodule