module carry_select_adder_16bit(sub, in0, in1, cin, sum, cout, v);

	input [15:0] in0,in1;
	input cin;
	input sub;
	output [15:0] sum;
	output cout;
	output v;
 
	wire [6:0] c;
	
	wire [15:0] tempin1;
	wire tempcin;
	
	assign tempcin = cin | sub;
	assign tempin1 = (sub)? in1 ^ 16'b1111111111111111 : in1;
 
	// first 2-bit by ripple_adder
	ripple_adder_2bit ra0(in0[1:0], tempin1[1:0], tempcin, sum[1:0], c[0]);
 
	carry_select_adder_2bit csa0(in0[3:2], tempin1[3:2], c[0], sum[3:2], c[1]);
	carry_select_adder_2bit csa1(in0[5:4], tempin1[5:4], c[1], sum[5:4], c[2]);
	carry_select_adder_2bit csa2(in0[7:6], tempin1[7:6], c[2], sum[7:6], c[3]);
	carry_select_adder_2bit csa3(in0[9:8], tempin1[9:8], c[3], sum[9:8], c[4]);
	carry_select_adder_2bit csa4(in0[11:10], tempin1[11:10], c[4], sum[11:10], c[5]);
	carry_select_adder_2bit csa5(in0[13:12], tempin1[13:12], c[5], sum[13:12], c[6]);
	carry_select_adder_2bit csa6(in0[15:14], tempin1[15:14], c[6], sum[15:14], cout);

	assign v = ((in0[15] & tempin1[15]) & ~sum[15]) | ((~in0[15] & ~tempin1[15]) & sum[15]);


endmodule
