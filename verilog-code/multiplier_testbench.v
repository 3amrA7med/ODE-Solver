module multiplier_testbench();
 
	reg signed [15:0] first_operand, second_operand;
	reg signed [12:0] temp,temp2,temp3; // used in display
  	wire signed [15:0] out;
 	
  	multiplier DUT(
    		.first_operand(first_operand),
    		.second_operand(second_operand),
    		.out(out)
  	);
 
	initial
	begin
    		first_operand = 16'b000000000011_1_001; // 3.5
    		second_operand =16'b000000101_0100_100; // 5.25
		#50 // Delay 50ps
		
		
		if(out != 16'b0001001001100101) $error(" Test1 Failed:Output is %f with scale factor = %f but it should be %f with scale facotr = %f"
		,$itor(out[15:3])*2.0**-5.0,$itor(out[2:0]) , $itor(16'b0001001001100)*2.0**-5.0,$itor(5));
		if(out == 16'b0001001001100101)$display("TEST1 Passed : %f x %f = %f", $itor(first_operand[15:3])*2.0**-1.0, $itor(second_operand[15:3])*2.0**-4.0,
					 $itor(out[15:3])*2.0**-5.0);
		// Output should be 18.375
    		#50
    		first_operand = 16'b111111111001_1_001; // -6.5
    		second_operand = 16'b0000000000100_000; // 4
		#50
		temp = first_operand[15:3];
		temp2 = out[15:3];
		temp3 = 16'b1111111001100;
		if(out != 16'b1111111001100001) $error("Test2 Failed: Output is %f with scale factor = %f but it should be %f with scale facotr = %f",
			$itor(temp2)*2.0**-1.0 ,$itor(out[2:0])
			, $itor(temp3)*2.0**-1.0,$itor(1));
		if(out == 16'b1111111001100001)$display("TEST2 Passed : %f x %f = %f",$itor(temp)*2.0**-1.0, $itor(second_operand[15:3]), $itor(temp2)*2.0**-1.0);
    		// Output should be -26
		#50
    		first_operand = 16'b00000000110_11_010; // 6.75
    		second_operand = 16'b1111111111100_000; // -4
		#50
		
		temp = second_operand[15:3];
		temp2 = out[15:3];
		temp3 = 16'b1111110010100;
		if(out != 16'b1111110010100010) $error("Test3 Failed: Output is %f with scale factor = %f but it should be %f with scale facotr = %f",
		$itor(temp2)*2.0**-2.0 ,$itor(out[2:0]), $itor(temp3)*2.0**-2.0,$itor(2));
		if(out == 16'b1111110010100010)$display("TEST3 Passed: %f x %f = %f",$itor(first_operand[15:3])*2.0**-2.0, $itor(temp), $itor(temp2)*2.0**-2.0);
    		// Output should be -27
		#50
  		first_operand = 16'b00000101_00011_101; // 5.09375
    		second_operand =16'b00000101_10001_101; // 5.53125
		#50
		
		if(out != 16'b0111000010110111)$error("Test4 Failed: Output is %f with scale factor = %f but it should be %f with scale facotr = %f",
		$itor(out[15:3])*2.0**-7.0,$itor(out[2:0]) , $itor(16'b0111000010110)*2.0**-7.0,$itor(7));
		if(out == 16'b0111000010110111)$display("TEST4 Passed: %f x %f = %f",$itor(first_operand[15:3])*2.0**-5.0, $itor(second_operand[15:3])*2.0**-5.0, $itor(out[15:3])*2.0**-7.0);
    		// Output should be 28.171875
		#50
    		first_operand = 16'b000111_1000000_111; // 7.5
    		second_operand = 16'b111111_0000000_111; // -1.0
		
		#50
		temp = second_operand[15:3];
		temp2 = out[15:3];
		temp3 = 16'b1110001000000;
		if(out != 16'b1110001000000111) $error("Test5 Failed: Output is %f with scale factor = %f but it should be %f with scale facotr = %f",
		$itor(temp2)*2.0**-7.0 ,$itor(out[2:0]), $itor(temp3)*2.0**-7.0,$itor(2));
		if(out == 16'b1110001000000111)$display("TEST5 Passed: %f x %f = %f",$itor(first_operand[15:3])*2.0**-7.0, $itor(temp)*2.0**-7.0, $itor(temp2)*2.0**-7.0);
    		// Output should be -27
		#200
		$finish;

    	end
endmodule
