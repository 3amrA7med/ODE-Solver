// The module takes 2 arguments with Fixed point representation and calculate their multiplication
module multiplier(first_operand, second_operand, out);
	// Fixed Point multiplication using Q format 
	// The number starts from bit "15" to bit "3" and total bits is 13, 
	// and its scale factor start from bit "2" to bit "0" and total bits is 3  
	input signed[15:0] first_operand;
	input signed[15:0] second_operand;
	reg signed[25:0] temp_result;
	reg [2:0]first_operand_scale_factor,second_operand_scale_factor,output_scale_factor;
	reg [3:0]temp_result_scale_factor, shift_factor = 0;
	reg [12:0]first_operand_number,second_operand_number,output_number;
	output reg signed[15:0] out;	

	always @(*)
	begin
		// Extracting the first number and its scale factor.
		first_operand_scale_factor = first_operand[2:0];
		first_operand_number = first_operand[15:3];
		// Extracting the second number and its scale factor.
		second_operand_scale_factor = second_operand[2:0];
		second_operand_number = second_operand[15:3];
		
		// Calulating the output number
		temp_result = first_operand_number * second_operand_number;

		// Calculate new scale factor
		temp_result_scale_factor = first_operand_scale_factor + second_operand_scale_factor;
		// If the result of the scale factor addition is greater than 7 we should make the scale factor of the output = 7 
		// , and shift the resulted number right 
		if(temp_result_scale_factor[3] == 1'b1)
		begin
			output_scale_factor = 3'b111;
			shift_factor = temp_result_scale_factor - 3'b111;
			temp_result = temp_result >>> shift_factor; // Shift and keep the sign
		end
		else
		begin 
			output_scale_factor = temp_result_scale_factor[2:0];
		end
		
		// Assign output number with the same Fixed point representation mentioned above 
		output_number = temp_result[12:0];
		assign out = {output_number,output_scale_factor} ;
	end    	
endmodule