module Division (reset, clk, dividend, divisor, Q,ready, overFlow);

	// Fixed Point Division using Q format 
	// The number starts from bit "N-1" to bit "3" and total bits is N-3, 
	// and its scale factor start from bit "2" to bit "0" and total bits is 3 

	// will determine the numner of bit in the input and output.
  	parameter N = 20;
	input clk;
	input reset;
	input [N-1:0] dividend;
	input [N-1:0] divisor;
	output reg [N-1:0] Q;
	output reg ready;
	output reg overFlow;

	reg [4:0]number_of_bits_in_dividend;
 
	reg [39:0] A =40'b0000000000000000000000000000000000000000;
	reg [2:0]first_operand_scale_factor,second_operand_scale_factor,output_scale_factor;
	reg [N-1:0]first_operand_number,second_operand_number, negated_second_operand_number;

	reg number;

	reg sign;
	// I commented this part to check that my code already synthesizable before using modules from my team


	// wire [N-1:0] sum;
	// wire cout;
	// wire v;
	// carry_select_adder_20bit cs0(1'b1, {17'b00000000000000000,first_operand_scale_factor}, {17'b00000000000000000,second_operand_scale_factor}, 1'b0, sum, cout, v);

	// wire [N-1:0] sum1;
	// wire cout1;
	// wire v1;
	// carry_select_adder_20bit cs1(1'b1, {17'b00000000000000000,second_operand_scale_factor}, {17'b00000000000000000,first_operand_scale_factor}, 1'b0, sum1, cout1, v1);

	// wire [N-1:0] sum2;
	// wire cout2;
	// wire v2;
	// reg [N-1:0]  inp;
	// //assign inp = flag2 ? negated_second_operand_number : 20'b00000000000000000000;
	// carry_select_adder_20bit cs2(1'b0,A[39:20],negated_second_operand_number, 1'b0, sum2, cout2, v2);

	// wire [N-1:0] sum3;
	// wire cout3;
	// wire v3;
	// reg [N-1:0]  inp3;
	// //assign inp3 = flag3 ? second_operand_number : 20'b00000000000000000000;
	// carry_select_adder_20bit cs3(1'b0,A[39:20],second_operand_number, 1'b0, sum3, cout3, v3);		
		
	always @(posedge clk)
	begin
		if (reset == 1)
		begin 
			A =40'b0000000000000000000000000000000000000000;
			number_of_bits_in_dividend = 5'b10100;
						// Extracting the first number and its scale factor.
			first_operand_scale_factor = dividend[2:0];
			first_operand_number[19:17] = (dividend[19] == 1) ? 3'b111 : 3'b000;  // Sign extend
			first_operand_number[16:0] = dividend[19:3];
			// Extracting the second number and its scale factor.
			second_operand_scale_factor = divisor[2:0];
			second_operand_number[19:17] = (divisor[19] == 1) ? 3'b111 : 3'b000; // Sign extend
			second_operand_number[16:0] = divisor[19:3];
			sign = first_operand_number[N-1] ^ second_operand_number[N-1];
			if (first_operand_number[N-1] == 1)
			begin 
				first_operand_number = -(first_operand_number);
			end
			if (second_operand_number[N-1] == 1)
			begin 
				second_operand_number = -(second_operand_number);
			end
			negated_second_operand_number = -(second_operand_number);
			if (first_operand_scale_factor > second_operand_scale_factor)
			begin
				assign number = first_operand_scale_factor - second_operand_scale_factor;
				if (number > 0)
				begin
					second_operand_number = second_operand_number << number;
					first_operand_number = first_operand_number << 3;
					second_operand_scale_factor = first_operand_scale_factor;
					output_scale_factor = 3;
				end
				else
				begin		
					first_operand_number = first_operand_number << 3;
					output_scale_factor = 3 ;
				end
			end
			else 
			begin
				assign number = second_operand_scale_factor - first_operand_scale_factor;
				if (number > 0)
				begin
					first_operand_number = first_operand_number << number;
					first_operand_number = first_operand_number << 3;
					first_operand_scale_factor = second_operand_scale_factor;
					output_scale_factor = 3;
				end
				else
				begin		
					first_operand_number = first_operand_number << 3;
					output_scale_factor = 3;
				end
			end
			A[19:0] = first_operand_number;
			A[39:20] = 20'b00000000000000000000;
			A = A << 1;
			number_of_bits_in_dividend = number_of_bits_in_dividend - 1;
		end
		else 
		begin
			if (number_of_bits_in_dividend != 5'b11111)
			begin
				if(A[39] == 1'b0)
				begin
					// Calulating the output number
					//A[39:20] = sum2;
					A[39:20] = A[39:20]+negated_second_operand_number;
					if(A[39] == 1'b1)
					begin
						A = A << 1;
						A[0] = 1'b0;
					end
					else
					begin 
						A = A << 1;
						A[0] = 1'b1;
					end
					number_of_bits_in_dividend = number_of_bits_in_dividend - 1;
				end
				else
				begin
					//A[39:20] = sum3;
					A[39:20] = A[39:20]+second_operand_number;
					if(A[39] == 1'b1)
					begin
						A = A << 1;
						A[0] = 1'b0;
					end
					else
					begin 
						A = A << 1;
						A[0] = 1'b1;
					end
					number_of_bits_in_dividend = number_of_bits_in_dividend - 1;
				end	
			end
			else 
			begin
				assign overFlow = 1'b0;
				A[39:20] = A[39:20] >> 1;
				assign Q = {A[19:0]};
				if (Q[N-1] == 1)
				begin
					overFlow = 1'b1;
				end
				else
				begin
					if (sign == 1)
					begin
						assign Q = -(Q);
					end
				end
				ready = 1'b1;
			end
		end
	end
	
endmodule

