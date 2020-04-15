module add_sub_cla(sub, in1, in2, cin, out, cout, invalid);

	input signed [15:0] in1;
	input signed [15:0] in2;
 	output reg signed [15:0] out;
	reg signed [19:0] tempIn1;
	reg signed [19:0] tempIn2;
	reg [2:0] diffScaleFactor;
	reg [2:0] newScaleFactor;
	wire [19:0] tempOut;
	input sub;
	input cin;
	output cout;
	output invalid;
	wire v;
	wire valid;
	
	assign tempIn1[19:13] = (in1[12] == 1) ? 7'b1111111 : 7'b0000000;
	assign tempIn1[12:0] = in1[12:0];
				
	assign tempIn2[19:13] = (in2[12] == 1) ? 7'b1111111 : 7'b0000000;
	assign tempIn2[12:0] = in2[12:0];	

	always @ (in1 or in2)
		if(in1[15:13] != in2[15:13]) begin

			if(in1[15:13] > in2[15:13]) begin
				diffScaleFactor = in1[15:13] - in2[15:13];
				tempIn2 = tempIn2 << diffScaleFactor;
				newScaleFactor = in1[15:13];

			end else begin
				diffScaleFactor = in2[15:13] - in1[15:13];
				tempIn1 = tempIn1 << diffScaleFactor;
				newScaleFactor = in2[15:13];			

			end

		end else begin
				newScaleFactor = in2[15:13];
		end

carry_lookahead_adder_20bit cs0(sub, tempIn1, tempIn2, cin, tempOut, cout, v);

assign out[12:0] = tempOut[12:0];
assign out[15:13] = newScaleFactor;

assign valid = !v && ((tempOut[19:12] == 8'b11111111) || (tempOut[19:12] == 8'b00000000));
assign invalid = !valid;

endmodule
