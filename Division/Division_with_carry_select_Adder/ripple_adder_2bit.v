module ripple_adder_2bit(in0, in1, cin, sum, cout);

	input [1:0] in0,in1;
	input cin;
	output [1:0] sum;
	output cout;
 
	wire c0;
 
	full_adder fa0(in0[0], in1[0], cin, sum[0], c0);
  
	full_adder fa1(in0[1], in1[1], c0, sum[1], cout);

endmodule
