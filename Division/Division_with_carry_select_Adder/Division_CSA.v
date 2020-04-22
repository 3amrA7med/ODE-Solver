module Division_CSA (reset, clk, dividend, divisor, Q,ready, overFlow, divideByZero);

	// Fixed Point Division using Q format 
	// The number starts from bit "N-1" to bit "3" and total bits is N-3, 
	// and its scale factor start from bit "2" to bit "0" and total bits is 3 

	// will determine the numner of bit in the input and output.
  	parameter N = 16;
	input clk;
	input reset;
	input [N-1:0] dividend;
	input [N-1:0] divisor;
	output reg [N-1:0] Q;
	output reg ready;
	output reg overFlow;
	output reg divideByZero;

	reg [4:0]number_of_bits_in_dividend;
 	//reg [4:0]iterator;
 	///reg [4:0]avialableBits;
	reg [31:0] A =32'b00000000000000000000000000000000;
	reg [2:0]first_operand_scale_factor,second_operand_scale_factor,output_scale_factor;
	reg [N-1:0]first_operand_number,second_operand_number, negated_second_operand_number;

	reg [2:0] number;

	reg sign;		
		
	wire [N-1:0] sum0;
	wire cout0;
	wire v0;
	carry_select_adder_16bit csa0(1'b1,{13'b0000000000000,dividend[15:13]},{13'b0000000000000,divisor[15:13]}, 1'b0, sum0, cout0, v0);

	wire [N-1:0] sum1;
	wire cout1;
	wire v1;
	carry_select_adder_16bit csa1(1'b1,{13'b0000000000000,divisor[15:13]},{13'b0000000000000,dividend[15:13]}, 1'b0, sum1, cout1, v1);

	wire [N-1:0] sum2;
	wire cout2;
	wire v2;
	carry_select_adder_16bit csa2(1'b0,A[31:16],negated_second_operand_number, 1'b0, sum2, cout2, v2);

	wire [N-1:0] sum3;
	wire cout3;
	wire v3;
	carry_select_adder_16bit csa3(1'b0,A[31:16],second_operand_number, 1'b0, sum3, cout3, v3);


	always @(posedge clk)
	begin
		if (reset == 1)
		begin 
			//avialableBits = 5'b00000;
			//iterator=5'b00000;
			A =32'b00000000000000000000000000000000;
			assign Q = 16'b0000000000000000;
			sign = 1'b0;
			assign ready = 1'b0;
			assign divideByZero = 1'b0;
			assign overFlow = 1'b0;
			number_of_bits_in_dividend = 5'b10000;
			// Extracting the first number and its scale factor.
			first_operand_scale_factor = dividend[15:13];
			first_operand_number[15:13] = (dividend[12] == 1) ? 3'b111 : 3'b000;  // Sign extend
			first_operand_number[12:0] = dividend[12:0];
			// Extracting the second number and its scale factor.
			second_operand_scale_factor = divisor[15:13];
			second_operand_number[15:13] = (divisor[12] == 1) ? 3'b111 : 3'b000; // Sign extend
			second_operand_number[12:0] = divisor[12:0];
			sign = first_operand_number[N-1] ^ second_operand_number[N-1];
			if (first_operand_number[N-1] == 1)
			begin 
				first_operand_number = -(first_operand_number);
			end
			if (second_operand_number[N-1] == 1)
			begin 
				second_operand_number = -(second_operand_number);	
			end
			
			//for (iterator = 5'b00000;iterator < 16; iterator=iterator+1)
			//begin 
							

			if (first_operand_scale_factor > second_operand_scale_factor)
			begin
				number = sum0[2:0];//first_operand_scale_factor - second_operand_scale_factor;
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
				number = sum1[2:0];//second_operand_scale_factor - first_operand_scale_factor;
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
			negated_second_operand_number = -(second_operand_number);
			A[15:0] = first_operand_number;
			A[31:16] = 16'b0000000000000000;
			A = A << 1;
			number_of_bits_in_dividend = number_of_bits_in_dividend - 1;
			if ( second_operand_number == 16'b0000000000000000 )
			begin 
				number_of_bits_in_dividend = 5'b11111;
				assign divideByZero = 1;
			end
		end
		else 
		begin
			if (number_of_bits_in_dividend != 5'b11111)
			begin
				if(A[31] == 1'b0)
				begin
					// Calulating the output number
					A[31:16] = sum2;
					if(A[31] == 1'b1)
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
					A[31:16] = sum3;
					if(A[31] == 1'b1)
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
				if (ready == 1'b0)
				begin
					A[31:16] = A[31:16] >> 1;
					if (A[15] == 1 || A[14] == 1 || A[13] == 1 || A[12] == 1)
					begin
						assign overFlow = 1'b1;
					end
					else
					begin
						if (sign == 1)
						begin
							A[15:0] = -(A[15:0]);
						end		
						A[15:13] = output_scale_factor; 
						if (ready == 1'b0)
						begin
							assign Q = A[15:0];
						end
						else
						begin
							assign Q = Q;
						end 
					end
					assign ready = 1'b1;
				end
			end
		end
	end
	
endmodule
