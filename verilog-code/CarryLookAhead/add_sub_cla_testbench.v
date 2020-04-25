module add_sub_cla_testbench();
 
	reg signed [15:0] first_operand, second_operand;
	reg sub, cin;
	reg signed [12:0] temp,temp2,temp3; // used in display
  	wire signed [15:0] out;
	wire invalid, cout;
 	
  	add_sub_cs DUT(
		.sub(sub),
    		.in1(first_operand),
    		.in2(second_operand),
		.cin(cin),
    		.out(out),
		.cout(cout),
		.invalid(invalid)
  	);
 
	initial
	begin
    		first_operand = 16'b0000000000000010; // 2
    		second_operand =16'b0000000000000011; // 3
		sub = 1'b0;	//add
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b0000000000000101) && (invalid == 1'b0))$display("TEST1 Passed");
		else $error(" Test1 Failed");
		// Output should be 5
    		#50

//================================================================================
    		first_operand = 16'b0000000000000010; // 2
    		second_operand =16'b0000000000000011; // 3
		sub = 1'b0;	//add
		cin = 1'b1;	
		#50 // Delay 50ps
		
		
		if((out == 16'b0000000000000110) && (invalid == 1'b0))$display("TEST2 Passed");
		else $error(" Test2 Failed");
		// Output should be 6
    		#50
//=================================================================================
    		first_operand = 16'b0000000000000110; // 6
    		second_operand =16'b0000000000000011; // 3
		sub = 1'b1;	//subtract
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b0000000000000011) && (invalid == 1'b0))$display("TEST3 Passed");
		else $error(" Test3 Failed");
		// Output should be 3
    		#50

//================================================================================
    		first_operand = 16'b0010000000000111; // 3.5
    		second_operand =16'b0100000000000011; // 0.625
		sub = 1'b0;	//add
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b0100000000010001) && (invalid == 1'b0))$display("TEST4 Passed");
		else $error(" Test4 Failed");
		// Output should be 4.25
    		#50

//================================================================================
    		first_operand = 16'b1000010010001101; // 72.8125
    		second_operand =16'b0110000101001010; // 41.25
		sub = 1'b0;	//add
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b1000011100100001) && (invalid == 1'b0))$display("TEST5 Passed");
		else $error(" Test5 Failed");
		// Output should be 114.0625
    		#50

//================================================================================
    		first_operand = 16'b1000010010001101; // 72.8125
    		second_operand =16'b0110000101001010; // 41.25
		sub = 1'b1;	//sub
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b1000000111111001) && (invalid == 1'b0))$display("TEST6 Passed");
		else $error(" Test6 Failed");
		// Output should be 31.5625
    		#50

//================================================================================
    		first_operand = 16'b1000010010001101; // 72.8125
    		second_operand =16'b1110000101001010 ; // 2.578125
		sub = 1'b0;	//add
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b1110010110110010) && (invalid == 1'b1))$display("TEST7 Passed");
		else $error(" Test7 Failed");
		// Output should be 11.390625
    		#50

//================================================================================
    		first_operand = 16'b1000010010010101; // 73.3125
    		second_operand =16'b0111110001001010 ; // -118.75
		sub = 1'b0;	//add
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b1001110100101001) && (invalid == 1'b0))$display("TEST8 Passed");
		else $error(" Test8 Failed");
		// Output should be -45.4375
    		#50

//================================================================================
    		first_operand = 16'b1000010010010101; // 73.3125
    		second_operand =16'b0111110001001010 ; // -118.75
		sub = 1'b1;	//sub
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b1000110000000001) && (invalid == 1'b0))$display("TEST9 Passed");
		else $error(" Test9 Failed");
		// Output should be 192.0625
    		#50

//================================================================================
    		first_operand = 16'b1011110010010111; // -27.28125
    		second_operand =16'b0111110001001010; // -118.75
		sub = 1'b1;	//subtract
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b1010101101101111) && (invalid == 1'b0))$display("TEST10 Passed");
		else $error(" Test10 Failed");
		// Output should be  91.46875
    		#50

//================================================================================
    		first_operand = 16'b1011110010010111; // -27.28125
    		second_operand =16'b011111101001010; // -91.0
		sub = 1'b1;	//subtract
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b1010011111110111) && (invalid == 1'b0))$display("TEST11 Passed");
		else $error(" Test11 Failed");
		// Output should be 63.71875
    		#50

//================================================================================

    		first_operand = 16'b1011110010010111; // -27.28125
    		second_operand =16'b011111101001011; // -90.5

		sub = 1'b0;	//add
		cin = 1'b0;	
		#50 // Delay 50ps
		
		
		if((out == 16'b1011000101000111) && (invalid == 1'b0))$display("TEST12 Passed");
		else $error(" Test12 Failed");
		// Output should be -117.78125
    		#50
		#200
		$finish;

    	end
endmodule

