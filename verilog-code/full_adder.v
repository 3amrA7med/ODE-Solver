module full_adder(in0, in1, cin, sum, cout);

	input in0;
	input in1;
	input cin;
 	output sum;
	output cout;
	
	assign sum = (in0 ^ in1) ^ cin;
	assign cout = (in0 & in1) | (cin & (in0 ^ in1));

endmodule
