module carry_select_adder_20bit(sub, in0, in1, cin, sum, cout, v);

	input [19:0] in0,in1;
	input cin;
	input sub;
	output [19:0] sum;
	output cout;
	output v;
 
	wire [8:0] c;
	
	reg [19:0] tempin1;
	reg tempcin;
	
	assign tempcin = cin | sub;
	assign tempin1 = (sub)? in1 ^ 20'b11111111111111111111 : in1;
 
	// first 2-bit by ripple_adder
	ripple_adder_2bit ra0(in0[1:0], tempin1[1:0], tempcin, sum[1:0], c[0]);
 
	carry_select_adder_2bit csa0(in0[3:2], tempin1[3:2], c[0], sum[3:2], c[1]);
	carry_select_adder_2bit csa1(in0[5:4], tempin1[5:4], c[1], sum[5:4], c[2]);
	carry_select_adder_2bit csa2(in0[7:6], tempin1[7:6], c[2], sum[7:6], c[3]);
	carry_select_adder_2bit csa3(in0[9:8], tempin1[9:8], c[3], sum[9:8], c[4]);
	carry_select_adder_2bit csa4(in0[11:10], tempin1[11:10], c[4], sum[11:10], c[5]);
	carry_select_adder_2bit csa5(in0[13:12], tempin1[13:12], c[5], sum[13:12], c[6]);
	carry_select_adder_2bit csa6(in0[15:14], tempin1[15:14], c[6], sum[15:14], c[7]);
	carry_select_adder_2bit csa7(in0[17:16], tempin1[17:16], c[7], sum[17:16], c[8]);
	carry_select_adder_2bit csa8(in0[19:18], tempin1[19:18], c[8], sum[19:18], cout);

	assign v = ((in0[19] & tempin1[19]) & ~sum[19]) | ((~in0[19] & ~tempin1[19]) & sum[19]);


endmodule
