module carry_select_adder_2bit(in0, in1, cin, sum, cout);

	input [1:0] in0,in1;
	input cin;
	output [1:0] sum;
	output cout;
 
	wire [1:0] s0,s1;
	wire c0,c1;
 
	ripple_adder_2bit ra0(in0, in1, 1'b0, s0, c0);
	ripple_adder_2bit ra1(in0, in1, 1'b1, s1, c1);
 
	mux2X1 #(2) ms0(s0, s1, cin, sum);
 	mux2X1 #(1) mc0(c0, c1, cin, cout);

endmodule
