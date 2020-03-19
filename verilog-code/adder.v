module adder(in1, in2, out);

	input signed [15:0] in1;
	input signed [15:0] in2;
 	output reg signed [15:0] out;
	reg signed [19:0] tempIn1;
	reg signed [19:0] tempIn2;
	reg [2:0] diffScaleFactor;
	reg [2:0] newScaleFactor;
	reg [20:0] tempOut;
	
	
	always @ (in1 or in2)
		if(in1[2:0] != in2[2:0]) begin

			tempIn1[19:13] = (in1[15] == 1) ? 7'b1111111 : 7'b0000000;
			tempIn1[12:0] = in1[15:3];
				
			tempIn2[19:13] = (in2[15] == 1) ? 7'b1111111 : 7'b0000000;
			tempIn2[12:0] = in2[15:3];

			if(in1[2:0] > in2[2:0]) begin
				diffScaleFactor = in1[2:0] - in2[2:0];
				tempIn2 = tempIn2 << diffScaleFactor;
				newScaleFactor = in1[2:0];


			end else begin
				diffScaleFactor = in2[2:0] - in1[2:0];
				tempIn1 = tempIn1 << diffScaleFactor;
				newScaleFactor = in2[2:0];			

			end
			tempOut = tempIn1 + tempIn2;
			out[2:0] = newScaleFactor;
			out[15:3] = tempOut[12:0];

		end else begin
			out[15:3] = in1[15:3] + in2[15:3];
			out[2:0] = in1[2:0];
		end




endmodule
